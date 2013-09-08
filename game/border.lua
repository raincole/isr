require 'vendor/class'

Border = class(Entity)

function Border:__init(name, rect)
	Border._base.__init(self, name)
	self.rect = rect
end

function Border:registerObservers()
	beholder.observe(Event.TRY_TO_MOVE, function(rect, velocity, callback)
        callback(rect:collisionTime(self.rect, velocity))
    end)
end

return Border
