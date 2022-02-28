if getDebug() then
    Events.OnCustomUIKey.Add(function(key)
        ---@type IsoPlayer | IsoGameCharacter | IsoGameCharacter | IsoLivingCharacter | IsoMovingObject player
        local player = getSpecificPlayer(0)

        --[[ 
            Test scenarios:
            Combineable:
            - Single selected item (collapsed/uncollapsed) with more than 1 item where the delta is 0.0 < {delta} < 1.0

            Non-combineable from 1 click:
            - COLLAPSED Glue and COLLAPSED Thread
            - COLLAPSED Glue and EXPANDED Thread
            - EXPANDED Glue and COLLAPSED Thread
            - EXPANDED Glue and EXPANDED Thread

            Non-combineable:
            - Stack of a single item where the delta is 0.0 < {delta} < 1.0 (ex. 1 Thread with delta of .3)
            - Stack of multiple items where one item with a delta of 0.0 < {delta} < 1.0 (ex. BlowTorch case below)
            - Stack of empty items
            - Stack of full items
         ]]

        if key == Keyboard.KEY_1 then
            -- Combine down to 2.4 total units of Thread (Expanded/Collapsed)
            player:getInventory():AddItem("Base.Thread", .1)
            player:getInventory():AddItem("Base.Thread", .2)
            player:getInventory():AddItem("Base.Thread", .8)
            player:getInventory():AddItem("Base.Thread", .4)
            player:getInventory():AddItem("Base.Thread", .1)
            player:getInventory():AddItem("Base.Thread", .1)
            player:getInventory():AddItem("Base.Thread", .1)
            player:getInventory():AddItem("Base.Thread", .1)
            player:getInventory():AddItem("Base.Thread", .2)
            player:getInventory():AddItem("Base.Thread", .3)
        end

        if key == Keyboard.KEY_2 then
            -- Combine down to 4.3 total units of Glue (Expanded/Collapsed)
            player:getInventory():AddItem("Base.Glue", .1)
            player:getInventory():AddItem("Base.Glue", .2)
            player:getInventory():AddItem("Base.Glue", .8)
            player:getInventory():AddItem("Base.Glue", .4)
            player:getInventory():AddItem("Base.Glue", .1)
            player:getInventory():AddItem("Base.Glue", .1)
            player:getInventory():AddItem("Base.Glue", .9)
            player:getInventory():AddItem("Base.Glue", .9)
            player:getInventory():AddItem("Base.Glue", .2)
            player:getInventory():AddItem("Base.Glue", .3)
            player:getInventory():AddItem("Base.Glue", .3)
        end

        if key == Keyboard.KEY_3 then
            -- Combine down to 3.6 total units of Wood Glue (Expanded/Collapsed)
            player:getInventory():AddItem("Base.Woodglue", .1)
            player:getInventory():AddItem("Base.Woodglue", .2)
            player:getInventory():AddItem("Base.Woodglue", .8)
            player:getInventory():AddItem("Base.Woodglue", .4)
            player:getInventory():AddItem("Base.Woodglue", .2)
            player:getInventory():AddItem("Base.Woodglue", .1)
            player:getInventory():AddItem("Base.Woodglue", .9)
            player:getInventory():AddItem("Base.Woodglue", .2)
            player:getInventory():AddItem("Base.Woodglue", .4)
            player:getInventory():AddItem("Base.Woodglue", .3)
        end

        if key == Keyboard.KEY_4 then
            -- Should not prompt for "Combine All" in collapsed or expanded state
            -- Spawn in some more blow torch to validate that it isn't trying to merge in empty to full/etc or full to empty/etc
            player:getInventory():AddItem("Base.BlowTorch", 0.0)
            player:getInventory():AddItem("Base.BlowTorch", 0.2)
            player:getInventory():AddItem("Base.BlowTorch", 1.0)
        end
    end)
end
