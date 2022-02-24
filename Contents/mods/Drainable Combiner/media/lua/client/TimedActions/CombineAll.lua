require "TimedActions/ISConsolidateDrainable"

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
end

ISCombineAll_OVERWRITE_new = ISConsolidateDrainable.new
function ISCombineAll:new(character, drainable, intoItem, time)
	return ISCombineAll_OVERWRITE_new(self, character, drainable, intoItem, time)
end