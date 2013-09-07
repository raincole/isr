require 'vendor/class'

local Stick = class(Entity)

function Stick:__init(name, ox, oy)
	Stick._base.__init(self, name)
	self.images = R.images.sticks[1]
	self.ox = ox
	self.oy = oy
	self.width = self.images.normal:getWidth()
	self.height = self.images.normal:getHeight()
	self.fired = false
	self.zIndex = 0
end

function Stick:registerObservers()
	beholder.observe(Event.CHECK_IN_RANGE, function(x, y, radius, callback)
		local sqrDistance = (self.ox - x) * (self.ox - x) + (self.oy - y) * (self.oy - y)
		if sqrDistance <= radius * radius then
			callback(self, sqrDistance)
		end
	end)
end

function Stick:draw()
	love.graphics.draw(self.images.normal, self.ox - self.width / 2, self.oy - self.height / 2)
end

return Stick

