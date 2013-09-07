require 'vendor/class'

local Stick = class(Entity)

function Stick:__init(name, ox, oy)
	self._base.__init(self, name)
	self.images = R.images.sticks[1]
	self.ox = ox
	self.oy = oy
	self.width = self.images.normal:getWidth()
	self.height = self.images.normal:getHeight()
	self.fired = false
end

function Stick:draw()
	love.graphics.draw(self.images.normal, self.ox - self.width / 2, self.oy - self.height / 2)
end

return Stick

