require "TimedActions/ISBaseTimedAction"
require "TimedActions/ISConsolidateDrainable"

ISCombineAll = ISBaseTimedAction:derive("ISCombineAll");

ISCombineAll_OVERWRITE_isValid = ISConsolidateDrainable.isValid
function ISCombineAll:isValid()
    return ISCombineAll_OVERWRITE_isValid(self)
end

ISCombineAll_OVERWRITE_update = ISConsolidateDrainable.update
function ISCombineAll:update()
    ISCombineAll_OVERWRITE_update(self)
end

ISCombineAll_OVERWRITE_start = ISConsolidateDrainable.start
function ISCombineAll:start()
    ISCombineAll_OVERWRITE_start(self)
end

ISCombineAll_OVERWRITE_stop = ISConsolidateDrainable.stop
function ISCombineAll:stop()
    ISCombineAll_OVERWRITE_stop(self)
end

ISCombineAll_OVERWRITE_perform = ISConsolidateDrainable.perform
function ISCombineAll:perform()
    ISCombineAll_OVERWRITE_perform(self)
    if self.onCompleteFunc then
        local args = self.onCompleteArgs
        self.onCompleteFunc(args[1], args[2])
    end

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

ISCombineAll_OVERWRITE_new = ISConsolidateDrainable.new
function ISCombineAll:new(character, drainable, intoItem, time)
    return ISCombineAll_OVERWRITE_new(self, character, drainable, intoItem, time)
end

function ISCombineAll:setOnComplete(func, arg1, arg2)
    self.onCompleteFunc = func
    self.onCompleteArgs = {arg1, arg2}
end
