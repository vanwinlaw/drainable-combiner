ISCombineThreadMenu = {};

function ISCombineThreadMenu.DoContextMenu(player, context, items)
    for i,v in pairs(items) do
        local item = v
        if not instanceof(v, "InventoryItem") then
            item = v.items[1]
        end

        if item:getType() == "Thread" then
            context:addOption(getText("UI_ContextMenu_CombineThread"), item, ISCombineThreadMenu.onCombineThread, player)
        end
    end
end

function ISCombineThreadMenu.onCombineThread()
    
end

Events.OnFillInventoryObjectContextMenu.Add(ISCombineThreadMenu.DoContextMenu);