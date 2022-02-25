ISCombineAllContextMenu = {};

function ISCombineAllContextMenu.DoContextMenu(player, context, items)
    if hasInvalidSetup(items) == true then
        return
    end

    local item = items[1]
    local contextItem = instanceof(item, "DrainableComboItem") and items or item.items
    if type(contextItem) == "table" and isValidToCombine(contextItem, player) == true then -- Collapsed Drainable Item
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

function hasInvalidSetup(items)
    --[[ 
        Valid setups - Do not allow cross types to simplify actions
        - When selecting two collapsed items(ex. Thread and Glue), that will present as 2 tables. Do not allow.
        - When selecting one collapsed item(ex. Thread) and a second uncollapsed(ex. 8 Glue for example). Do not allow.
        - When selecting two uncollapsed items (8 Thread and 8 Glue for example). Do not allow.
     ]]

    local s = {}
    local t = {}
    for _, v in pairs(items) do
        if instanceof(v, "DrainableComboItem") == true then
            if s["DrainableComboItem"] ~= nil then
                s["DrainableComboItem"] = s["DrainableComboItem"] + 1
            else 
                s["DrainableComboItem"] = 1
            end
            t[v:getType()] = true
        elseif type(v) == "table" then
            if s["table"] ~= nil then
                s[type(v)] = s[type(v)] + 1
            else
                s[type(v)] = 1
            end
        end
    end
    
    if s["table"] ~= nil and s["DrainableComboItem"] ~= nil then
        return true
    elseif s["table"] ~= nil and s["table"] > 1 then
        return true
    elseif s["DrainableComboItem"] ~= nil and areOfSameType(t) ~= true then
        return true
    end

    return false
end

function areOfSameType(types)
    local numOfTypes = 0
    for _, v in pairs(types) do
        numOfTypes = numOfTypes + 1
    end
    return numOfTypes == 1
end

function isValidToCombine(items, player)
    local character = getSpecificPlayer(player)
    local inventory = character:getInventory()
    local totalCombineable = 0

    for _, s in pairs(items) do
        if not instanceof(s, "DrainableComboItem") 
        or inventory:contains(s) ~= true 
        or s:canConsolidate() ~= true then
            return false
        end

        if s:getDelta() < 1.0 and s:getDelta() > 0.0 then
            totalCombineable = totalCombineable + 1
        end
    end

    -- ONLY WHEN COLLAPSED if 2 items in inventory and first item is 10% and the rest are 100%, it will think it can be combined
    if items[1] == items[2] and (items[1]:getDelta() < 1.0 and items[1]:getDelta() > 0.0) then
        return (totalCombineable - 1) > 1
    end
    return totalCombineable > 1
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
