---@type {[string]: vec4}
Config.coords = { -- init key with coords for every Config table
    ['reseller_1'] = vec4(118.22733306885, -1328.2004394531, 29.356643676758-1, 298.95544433594),
}

---@class priceProps
---@field weapon_name number

---@type {[string]: priceProps}
Config.price = {
    ['reseller_1'] = { -- key from Config.coords
        ['weapon_pistol'] = 500, ['weapon_assaultrifle'] = 5000, ['weapon_knife'] = 10, ['weapon_appistol'] = 1250
    }
}

---@class moneyProps
---@field value string
---@field label string

---@type {[string]: moneyProps}
Config.money = {
    ['reseller_1'] = { -- key from Config.coords
        {value = 'money', label = 'Cash'}, -- index 1 set per default
        {value = 'black_money', label = 'Argent sale'},
        --{value = 'bank', label = 'Banque'}
    }
}