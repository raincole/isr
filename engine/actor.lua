require 'vendor/class'

local Actor = class(Entity)

function Actor:__init(name, image, x, y)
	self._base.__init(self, name)
	self.image = image
	self.x = x
	self.y = y
end

function Actor:draw()
	love.graphics.draw(self.image, self.x - self.ox, self.y - self.oy)
end

return Actor
