ISCombineAllContextMenu = {};

function ISCombineAllContextMenu.DoContextMenu(player, context, items)
    local combineable = {}
    combineable = categorizeCombineable(items)

    local contextItem = items[1]
    if canCombineAll(combineable, player) then
        context:addOption(getText("UI_ContextMenu_CombineAll"), contextItem, ISCombineAllContextMenu.onCombineAll,
            player)
    end
end



function ISCombineAllContextMenu.onCombineAll(items, player)
    publishAction(items, player)
end

function ISCombineAllContextMenu.onCombineAllComplete(items, player)
    publishAction(items, player)
end

function canCombineAll(items, player)
    local character = getSpecificPlayer(player)
    local inventory = character:getInventory()

    for _, type in pairs(items) do
        local totalCombineable = 0

        for _, item in pairs(type) do
            if not instanceof(item, "DrainableComboItem") or inventory:contains(item) ~= true or item:canConsolidate() ~=
                true then
                return false
            end

            if item:getDelta() < 1.0 and item:getDelta() > 0.0 then
                totalCombineable = totalCombineable + 1
            end
        end

        if type[1] == type[2] and (type[1]:getDelta() < 1.0 and type[1]:getDelta() > 0.0) then --if collapsed, account for ghost row
            totalCombineable = totalCombineable - 1
        end

        if totalCombineable <= 1 then
            return false
        end
    end
    return true
end

function categorizeCombineable(items, existingCombineable)
    local combineable = existingCombineable ~= nil and existingCombineable or {}

    for _, v in pairs(items) do
        if instanceof(v, "DrainableComboItem") == true then -- if expanded
            if combineable[v:getType()] ~= nil then -- if the type already exists in table
                table.insert(combineable[v:getType()], v)
            else
                combineable[v:getType()] = {v}
            end
        elseif type(v) == "table" then -- if collapsed
            local tableItems = v.items
            categorizeCombineable(tableItems, combineable)
        end
    end

    return combineable
end

function publishAction(items, player)
    local consolidateableItems = getConsolidateable(items)
    local firstItem = consolidateableItems[1]
    local lastItem = consolidateableItems[#consolidateableItems]

    if firstItem ~= lastItem then
        local action = ISCombineAll:new(player, firstItem, lastItem, 90)
        action:setOnComplete(ISCombineAllContextMenu.onCombineAllComplete, consolidateableItems, player)
        ISTimedActionQueue.add(action)
    end
end

function getConsolidateable(items)
    local consolidateable = {}
    for _, v in pairs(items) do
        if v:getDelta() < 1.0 and v:getDelta() > 0.0 then
            table.insert(consolidateable, v)
        end
    end
    return consolidateable
end

Events.OnFillInventoryObjectContextMenu.Add(ISCombineAllContextMenu.DoContextMenu);
