require 'vendor/class'

local Stick = class(Entity)

function Stick:__init(name, ox, oy)
	self._base.__init(self, name)
	self.image = R.images.sticks[math.random(#R.images.sticks)]
	-- self.anim = R.anims.fire
	self.ox = ox
	self.oy = oy
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.fired = false
end

function Stick:draw()
	love.graphics.draw(self.image, self.ox - self.width / 2, self.oy - self.height / 2)
end

return Stick

