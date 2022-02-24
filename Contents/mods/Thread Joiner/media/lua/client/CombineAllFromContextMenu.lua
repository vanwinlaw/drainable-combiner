ISCombineAllMenu = {};

function ISCombineAllMenu.DoContextMenu(player, context, items)
    local item = items[1]
    if type(item) == "table" and isValidToCombine(item.items, player) == true then -- Collapsed Drainable Item
        context:addOption(getText("UI_ContextMenu_CombineAll"), item, ISCombineAllMenu.onCombineAll, player)
    end
end

function ISCombineAllMenu.onCombineAll(items, player)
    print("You clicked Combine All!")
end

function isValidToCombine(items, player)
    local character = getSpecificPlayer(player)

    for _, s in pairs(items) do
        if not instanceof(s, "DrainableComboItem") or character:getInventory():contains(s) ~= true or s:canConsolidate() ~= true then
            return false
        end
    end
    return true
end

Events.OnFillInventoryObjectContextMenu.Add(ISCombineAllMenu.DoContextMenu);
