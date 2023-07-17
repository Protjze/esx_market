if not lib then return end

local ox_target <const> = exports.ox_target
local zones, ped = {}, {}

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    if next(zones) then
        for k in pairs(zones) do
            zones[k]:remove()
            if ped[k] then
                ped[k]:remove()
            end
        end
    end
end)

local function RemovePedObj(self)
    if DoesEntityExist(self.ped) then
        DeleteEntity(self.ped)
    end
    return nil, collectgarbage()
end

local function CreatePedObj(model, coords, data, weapon)
    local self = {}

    self.model = type(model) == 'string' and joaat(model) or model

    self.vec4 = coords
    self.vec3 = vec3(self.vec4.x, self.vec4.y, self.vec4.z)

    self.data = {}
    self.data.blockevent = data?.blockevent or true
    self.data.freeze = data?.freeze or true
    self.data.godmode = data?.godmode or true
    self.data.variation = data?.variation

    self.weapon = weapon?.model and {} or false

    lib.requestModel(model)

    local ped = CreatePed(_, self.model, self.vec4.x, self.vec4.y, self.vec4.z, self.vec4.w, false, true)
    
    self.ped = ped
    SetBlockingOfNonTemporaryEvents(ped, self.data.blockevent)
    SetEntityInvincible(ped, self.data.godmode)
    FreezeEntityPosition(ped, self.data.freeze)
    SetModelAsNoLongerNeeded(self.model)

    if self.data.variation then
        SetPedComponentVariation(ped, self.data.variation)
    else
        SetPedDefaultComponentVariation(ped)
    end

    if self.weapon then
        self.weapon.model = type(weapon.model) == 'string' and joaat((weapon.model):upper()) or weapon.model
        self.weapon.ammo = weapon.ammo or 0
        self.weapon.visible = weapon.visible or true
        GiveWeaponToPed(ped, self.weapon.model, self.weapon.ammo, self.weapon.visible, true)
    end

    self.remove = RemovePedObj

    return self
end

local function OpenMenu(self, id)
    for key, item in pairs(self.sub) do
        local options = {}
        for k,v in pairs(item) do
            if not Config.price[id][k] then goto skip end
            options[#options+1] = {
                title = v.label,
                description = ("Prix : %s$"):format(Config.price[id][k]),
                icon = v.icon or '',
                image = v.image and #v.image > 0 and v.image or nil,
                onSelect = function()
                    print(json.encode(v, {indent=true}), k, key)
                    local input = lib.inputDialog(v.label, {
                        {type = 'number', label = 'Quantité', description = "Nombre d'arme que vous voulez acheter?", default = 1, icon = 'calculator'},
                        {type = 'select', label = 'Argent', description = "Choisisser moyen de paiement...", options = Config.money[id], default = Config.money[id][1].value, icon = 'sack-dollar'}
                    })
                    if not input or input[1] < 1 or not input[2] then
                        lib.showContext(key)
                    else
                        local result, msg = lib.callback.await('esx_blackmarket:callabck:buy', false, id, input[2], k, input[1])
                        if not result then
                            if msg then
                                lib.notify({
                                    title = self.title or 'Black Market',
                                    description = msg,
                                    type = 'error',
                                    duration = 3000
                                })
                            end
                            lib.showContext(key)
                        else
                            lib.notify({
                                title = self.title or 'Black Market',
                                description = msg,
                                type = 'success',
                                duration = 3000
                            })
                        end
                    end
                end
            }
            ::skip::
        end
        lib.registerContext({
            id = key,
            title = Config.cat[key] or key,
            menu = 'supv_bl:main',
            options = options
        })
    end

    lib.registerContext({
        id = 'supv_bl:main',
        title = self.title or 'Black Market',
        options = self.main
    })

    lib.showContext('supv_bl:main')
end

for k,v in pairs(Config.coords) do
    zones[k] = lib.points.new(vec3(v.x, v.y, v.z), 30, {
        vec4 = v,
        ped = Config.ped[k],
        menu = Config.menu[k],
        target = Config.target[k]
    })

    local zone = zones[k]

    function zone:onEnter()
        ped[k] = CreatePedObj(self.ped.model, self.vec4, self.ped.data, self.ped.weapon)
        ox_target:addLocalEntity(ped[k].ped, {
            {
                name = self.target.name,
                icon = self.target.icon or 'fa-solid fa-person',
                label = self.target.label or 'Interagir',
                groups = self.target.groups or nil,
                canInteract = function(entity, distance, coords, name, bone)
                    return distance < 2
                end,
                onSelect = function(data)
                    OpenMenu(self.menu, k)
                end
            }
        })
    end

    function zone:onExit()
        ox_target:removeLocalEntity(ped[k].ped, self.target.name)
        ped[k] = ped[k]:remove()
    end
end
