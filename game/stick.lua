require 'vendor/class'

local Stick = class(Entity)

function Stick:__init(name, x, y)
	Stick._base.__init(self, name)
	local rand = math.random(#R.images.sticks)
	self.image = R.images.sticks[rand]
	self.x = x
	self.y = y
	self.width = R.metadatas.stick.size.width
	self.height = R.metadatas.stick.size.height
	self.ox = self.width / 2
	self.oy = self.height / 2
	self.fired = false
	self.zIndex = 0
	self.burnTime = 20
	self.burnTimer = nil

	self.name = name

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

	if self.burnTimer == nil and self.fired == true then 
		self.burnTimer = Timer(self.name, self.burnTime)
	end

	if self.burnTimer ~= nil and self.burnTimer:isTimeUp() == true then
		self.fired = false
		self.burnTimer = nil
		getStickManager():changeBurningStickNum(-1)
		getStickManager():removeStick(self)
	end

	if self.fired and not self.toRemove then
		local sticks = {}
		beholder.trigger(Event.CHECK_IN_RANGE, self._fire.x, self._fire.y, R.metadatas.fire.burnRadius,
			function(item, sqrDistance)
				table.insert(sticks, item)
			end
		)
		if #sticks >= R.metadatas.campfire.upgradeThreshold then
			local campfire = Campfire('campfire', self._fire.x, self._fire.y)
			Game.currentScreen:addEntity(campfire)

			for i, v in ipairs(sticks) do
				if v.fired == true then
					v.fired = false
					v.burnTimer = nil
					getStickManager():changeBurningStickNum(-1)
				end
				getStickManager():removeStick(v)
			end
		end
	end
end

function Stick:draw()
	love.graphics.drawq(self.image, R.metadatas.stick.quad.normal, self.x - self.ox, self.y - self.oy)
	if self.fired == true then
		self._fire:draw()
	end
end

function Stick:isFired()
	return self._fire
end

return Stick

