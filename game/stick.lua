require 'vendor/class'

local Stick = class(Entity)

function Stick:__init(name, x, y)
	Stick._base.__init(self, name)
	local rand = math.random(#R.images.sticks)
	self.image = R.images.sticks[rand]
	self.x = math.floor(x)
	self.y = math.floor(y)
	self.width = R.metadatas.stick.size.width
	self.height = R.metadatas.stick.size.height
	self.ox = math.floor(self.width / 2)
	self.oy = math.floor(self.height / 2)
	self.fired = false
	self.glow = false
	self.zIndex = 0
	self.burnTime = R.metadatas.campfire.oneStickLifespan
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
		if self.toRemove == false and sqrDistance <= radius * radius then
			callback(self, sqrDistance)
		end
	end)
end

function Stick:update(dt)
	self._fire.x = self.x - self.ox + self.fireOffset.x
	self._fire.y = self.y - self.oy + self.fireOffset.y
	Stick._base.update(self, dt)

	if self.burnTimer ~= nil and self.burnTimer:isTimeUp() == true then
		self.fired = false
		self.burnTimer = nil
		Game.SceneManager:getNowRunning().stickManager:changeBurningStickNum(-1)
		Game.SceneManager:getNowRunning().stickManager:removeStick(self)
	end

	if self.fired and not self.toRemove then
		local sticks = {}
		beholder.trigger(Event.CHECK_IN_RANGE, self._fire.x, self._fire.y, R.metadatas.fire.burnRadius,
			function(item, sqrDistance)
				table.insert(sticks, item)
			end
		)
		if #sticks >= R.metadatas.campfire.upgradeThreshold then
			Game.SceneManager:getNowRunning().stickManager:changeBurningStickNum(1)
			local campfire = Campfire('campfire', self._fire.x, self._fire.y, #sticks)
			-- TODO: provide a function to push entity to root
			Game.SceneManager:getNowRunning()._screen:addEntity(campfire)

			for i, v in ipairs(sticks) do
				if v.fired == true then
					v.fired = false
					v.burnTimer = nil
					Game.SceneManager:getNowRunning().stickManager:changeBurningStickNum(-1)
				end
				Game.SceneManager:getNowRunning().stickManager:removeStick(v)
			end
		end
	end
end

function Stick:draw()
	if self.glow then
		love.graphics.drawq(self.image, R.metadatas.stick.quad.glow, self.x - self.ox, self.y - self.oy)
	else
		love.graphics.drawq(self.image, R.metadatas.stick.quad.normal, self.x - self.ox, self.y - self.oy)
	end
	self.glow = false
	if self.fired == true then
		love.graphics.printf( string.format("%.1f",self.burnTimer:getRemainTime()),
				self.x - self.width/2 , self.y + 10 , 100, "left" )
		self._fire:draw()
	end
end

function Stick:getFired()
	self.fired = true
	if self.burnTimer == nil then
		self.burnTimer = Timer(self.name, self.burnTime)
	end
end

return Stick

