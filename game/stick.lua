require 'vendor/class'

local Stick = class(Entity)

function Stick:__init(name, x, y)
	Stick._base.__init(self, name)
	local rand = math.random(#R.images.sticks)
	self.image = R.images.sticks[rand]
	self.x = x
	self.y = y
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.ox = self.width / 2
	self.oy = self.height / 2
	if math.random(2) == 1 then
		self.fired = false
	else
		self.fired = true
	end
	self.zIndex = 0

	self.fireOffset = R.metadatas.stick.firePosition[rand]
	local firePos = { x = self.x - self.ox + self.fireOffset.x, y = self.y - self.oy + self.fireOffset.y}
	self._fire = StickFire("fire: " .. name, firePos.x, firePos.y)
	self:addEntity(self._fire)
end

function Stick:registerObservers()
	beholder.observe(Event.CHECK_IN_RANGE, function(x, y, radius, callback)
		local sqrDistance = (self.x - x) * (self.x - x) + (self.y - y) * (self.y - y)
		if sqrDistance <= radius * radius then
			callback(self, sqrDistance)
		end
	end)
end

function Stick:update(dt)
	self._fire.x = self.x - self.ox + self.fireOffset.x
	self._fire.y = self.y - self.oy + self.fireOffset.y
	Stick._base.update(self, dt)
end

function Stick:draw()
	love.graphics.draw(self.image, self.x - self.ox, self.y - self.oy)
	if self.fired == true then
		self._fire:draw()
	end
end

return Stick

