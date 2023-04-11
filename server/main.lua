local cfg <const>, ox_inv <const> = Config, exports.ox_inventory

lib.callback.register('esx_blackmarket:callabck:buy', function(source, key, account, item, count)
    local player = ESX.GetPlayerFromId(source)
    if player then
        local distance = #(player.getCoords(true) - cfg.coords[key].xyz)
        if distance > 2 then return false, "👀" end
        local acc = player.getAccount(account)
        if acc.money < (cfg.price[key][item]*count) then return false, ("Vous n'avez pas assez d'argent (%s)!"):format(acc.label) end
        if ox_inv:CanCarryItem(source, item, count) then
            ox_inv:AddItem(source, item, count)
            player.removeAccountMoney(account, cfg.price[key][item]*count)
            return true, "Achat avec succès!"
        else
            return false
        end
    end
end)