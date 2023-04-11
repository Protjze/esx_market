---@class targetProps
---@field name string
---@field icon? string
---@field label string
---@field groups? table

---@type {[string]: targetProps}
Config.target = {
    ['reseller_1'] = { -- key from Config.coords
        name = 'ox:reseller1', -- change name for every reseller you make
        icon = "fa-solid fa-person",
        label = 'Interagir',
        --groups = {vagos = 2, ballas = 3}, -- optional you can comment
    }
}

---@class pedProps
---@field model string|hash
---@field data? {blockevent?: boolean-true, freeze?: boolean-true, godmode?: boolean-true, variation?: integer-0}|nil-false  ---@default {blockevent = true, freeze = true, godmode = true, variation = 0}
---@field weapon? {model: string|hash, ammo?: integer-0, visible?: boolean|true}|nil-false

---@type {[string]: pedProps}
Config.ped = {
    ['reseller_1'] = { -- key from Config.coords
        model = `s_m_m_security_01`,
        --data = nil, -- or {}
        --weapon = nil -- or {}
    }
}

---@class categorieProps
---@field [string]: string
Config.cat = {
    ['rifle'] = "Fusil d'assaut",
    ['melee'] = "Arme de mélée",
    ['pistol'] = "Arme de poing"
}

---@class mainProps
---@field title string
---@field description? string
---@field menu categorieProps -- key from Config.cat
---@field icon? string

---@class weaponProps
---@field label string
---@field image string

---@class subProps
---@field [weapon_name: string]: weaponProps

---@class menuProps
---@field title string
---@field main mainProps
---@field sub {[menu]: subProps}

---@type {[string]: menuProps}
Config.menu = {
    ['reseller_1'] = { -- key from Config.coords
        title = 'Jo le bargo',
        main = {
            {
                title = 'Melée',
                description = nil,
                menu = 'melee', -- key from Config.cat
                icon = 'utensils'
            },
            {
                title = 'Pistolet',
                description = nil,
                menu = 'pistol', -- key from Config.cat
                icon = 'gun'
            },
            {
                title = 'Fusil',
                description = nil,
                menu = 'rifle', -- key from Config.cat
                icon = 'person-rifle'
            },
        },

        sub = {
            ---@type weaponProps
            ['melee'] = { -- key from main.menu
                ['weapon_knife'] = {
                    label = "Couteau",
                    image = "https://raw.githubusercontent.com/overextended/ox_inventory/main/web/images/WEAPON_KNIFE.png",
                }
            },
    
            ---@type weaponProps
            ['pistol'] = { -- key from main.menu
                ['weapon_pistol'] = {
                    label = "Pistolet",
                    image = "https://raw.githubusercontent.com/overextended/ox_inventory/main/web/images/WEAPON_PISTOL.png",
                },
                ['weapon_appistol'] = {
                    label = "Pistolet",
                    image = "https://raw.githubusercontent.com/overextended/ox_inventory/main/web/images/WEAPON_APPISTOL.png",
                }
            },
    
            ---@type weaponProps
            ['rifle'] = { -- key from main.menu
                ['weapon_assaultrifle'] = {
                    label = "Ak-47",
                    image = "https://raw.githubusercontent.com/overextended/ox_inventory/main/web/images/WEAPON_ASSAULTRIFLE.png"
                }
            }
        }
    }
}