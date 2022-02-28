ISCombineAllContextMenu = {};

function ISCombineAllContextMenu.DoContextMenu(player, context, items)
    local contextItem = items[1]
    if canCombineAll(items, player) then
        context:addOption(getText("UI_ContextMenu_CombineAll"), items, ISCombineAllContextMenu.onCombineAll, player)
    end
end

function ISCombineAllContextMenu.onCombineAll(items, player)
    publishAction(items, player)
end

function canCombineAll(items, player)
    local combineable = {}
    local types = {}
    combineable, types = categorizeCombineable(items)
    local character = getSpecificPlayer(player)
    local inventory = character:getInventory()

    if #types == 0 then
        return false
    end

    for _, type in pairs(combineable) do
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

        if type[1] == type[2] and (type[1]:getDelta() < 1.0 and type[1]:getDelta() > 0.0) then -- if collapsed, account for ghost row
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
    local types = {}

    for _, v in pairs(items) do
        if instanceof(v, "DrainableComboItem") == true then -- if expanded
            if v:getDelta() < 1.0 and v:getDelta() > 0.0 then
                if combineable[v:getType()] ~= nil then -- if the type already exists in table
                    table.insert(combineable[v:getType()], v)
                else
                    combineable[v:getType()] = {v}
                end
            end
        elseif type(v) == "table" then -- if collapsed
            local tableItems = v.items
            categorizeCombineable(tableItems, combineable)
        end
    end

    for _, v in pairs(combineable) do
        if #v > 1 then
            local type = v[1]:getType()
            table.insert(types, type)
        end
    end

    return combineable, types
end

function publishAction(items, player)
    local combineableItems = {}
    local types = {}
    combineableItems, types = categorizeCombineable(items)

    local typeToCombine = types[1]
    if typeToCombine ~= nil then
        local itemsToCombine = combineableItems[typeToCombine]
        local firstItem = itemsToCombine[1]
        local lastItem = itemsToCombine[#itemsToCombine]

        if firstItem ~= lastItem then
            local action = ISCombineAll:new(player, firstItem, lastItem, 90)
            action:setOnComplete(ISCombineAllContextMenu.onCombineAll, items, player)
            ISTimedActionQueue.add(action)
        end
    end
end

Events.OnFillInventoryObjectContextMenu.Add(ISCombineAllContextMenu.DoContextMenu);
