require 'vendor/class'

local Stick = class(Entity)

function Stick:__init(name, ox, oy)
	self._base.__init(self, name)
	self.image = R.images.stick[1]
	self.ox = ox
	self.oy = oy
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	-- 30 x 16
end

function Stick:draw()
	love.graphics.draw(self.image, self.ox - self.width / 2, self.oy - self.height / 2)
end

return Stick

