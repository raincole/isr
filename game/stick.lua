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
	self.zIndex = 0
end

function Stick:registerObservers()
	beholder.observe(Event.TRY_PICK, function(player, x, y, radius)
		if((self.ox - x) * (self.ox - x) + (self.oy - y) * (self.oy - y) <= radius * radius) then
			if player:pick(self) then
				self:removeSelf()
			end
		end
	end)
end

function Stick:draw()
	love.graphics.draw(self.image, self.ox - self.width / 2, self.oy - self.height / 2)
end

return Stick

