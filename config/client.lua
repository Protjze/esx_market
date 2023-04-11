Config.target = {
    ['reseller_1'] = {
        name = 'ox:reseller1', -- change name for every reseller you make
        icon = "fa-solid fa-person",
        label = 'Interagir',
        --groups = {vagos = 2, ballas = 3}, -- optional you can comment
    }
}

Config.ped = {
    ['reseller_1'] = {
        model = `s_m_m_security_01`,
        --data = {}, -- or nil
        --weapon = {} -- or nil
    }
}

Config.cat = {
    ['rifle'] = "Fusil d'assaut",
    ['melee'] = "Arme de mélée",
    ['pistol'] = "Arme de poing"
}

Config.menu = {
    ['reseller_1'] = {
        title = 'Jo le bargo',
        ['main'] = {
            {
                title = 'Melée',
                description = nil,
                menu = 'melee',
                icon = 'utensils'
            },
            {
                title = 'Pistolet',
                description = nil,
                menu = 'pistol',
                icon = 'gun'
            },
            {
                title = 'Fusil',
                description = nil,
                menu = 'rifle',
                icon = 'person-rifle'
            },
        },

        ['sub'] = {
            ['melee'] = {
                ['weapon_knife'] = {
                    label = "Couteau",
                    image = "https://raw.githubusercontent.com/overextended/ox_inventory/main/web/images/WEAPON_KNIFE.png",
                }
            },
    
            ['pistol'] = {
                ['weapon_pistol'] = {
                    label = "Pistolet",
                    image = "https://raw.githubusercontent.com/overextended/ox_inventory/main/web/images/WEAPON_PISTOL.png",
                },
                ['weapon_appistol'] = {
                    label = "Pistolet",
                    image = "https://raw.githubusercontent.com/overextended/ox_inventory/main/web/images/WEAPON_APPISTOL.png",
                }
            },
    
            ['rifle'] = {
                ['weapon_assaultrifle'] = {
                    label = "Ak-47",
                    image = "https://raw.githubusercontent.com/overextended/ox_inventory/main/web/images/WEAPON_ASSAULTRIFLE.png"
                }
            }
        }
    }
}