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
    local totalCombineable = 0

    for _, s in pairs(items) do
        if not instanceof(s, "DrainableComboItem") 
        or character:getInventory():contains(s) ~= true 
        or s:canConsolidate() ~= true 
        then
            return false
        end

        if s:getDelta() < 1.0 and s:getDelta() > 0.0 then
            totalCombineable = totalCombineable + 1
        end
    end
    return calculateTotalCombineable(totalCombineable, items) > 1
end

--[[ calculateTotalCombineable is to account for the first duplicate row and to not account for it as combineable ]]
function calculateTotalCombineable(total, items)
    local firstDelta = items[1]:getDelta()
    if firstDelta == 0.0 or firstDelta == 1.0 then
        return total
    end

    return total - 1
end

Events.OnFillInventoryObjectContextMenu.Add(ISCombineAllMenu.DoContextMenu);
