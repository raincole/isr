require 'vendor/class'

local Player = class(Animator)

function Player:__init(name)
	Player._base.__init(self, name, R.anims.player())
	self.x = 0
	self.y = 0
	self.ox = 16
	self.oy = 35
	self.width = 32
	self.height = 20
	self.zIndex = 10

	self.moving = false
	self.speed = 120
	self.pickingRadius = 40
	self.lightRadius = 80
	self.handLength = 20
	self.dir = Direction.CENTER
	self.targetItem = nil
	self.holdingItem = nil
	self.fire = StickFire("fire: " .. name, 0, 0)
end

function Player:update(dt)
	self:_handleMove(dt)
	self:_updateTarget()

	local anim = self:getCurrentAnim()
	local frame = anim.frames[anim.position]
	local frameX, frameY, frameW, frameH = frame:getViewport()
	local frameID = frameX / frameW + (frameY / frameH) * 4 + 1
	local firePosRel = R.metadatas.player.firePosition[frameID]
	self.fire.x = self.x - self.ox + firePosRel.x
	self.fire.y = self.y - self.oy + firePosRel.y
	self.fire:update(dt)
	if self.moving then
		self:getCurrentAnim():update(dt)
	else
		self:getCurrentAnim():reset()
	end

	if self.holdingItem and self.holdingItem:isFired() then
		beholder.trigger(Event.LIGHT_SOURCE, self.x, self.y, self.lightRadius)
	end
end

function Player:draw()
	Player._base.draw(self)
	if self.holdingItem then
		if self.holdingItem.fired == true then
			self.fire:draw()
		end
	end
end

function Player:_handleMove(dt)
	local dir = Direction.CENTER
	local keys = { 'up', 'right', 'down', 'left', 'w', 'd', 's', 'a' }
	for i, key in ipairs(keys) do
		if love.keyboard.isDown(key) then
			dir = Direction.comebine(dir, Direction.fromKey(key))
		end
	end

	self.moving = false
	if dir ~= Direction.CENTER then
		self.dir = dir
		self.moving = true

		local vect = Direction.toVect(dir)
		local frameSpeed = self.speed * dt
		self:tryToMove(vect, frameSpeed)
	end
end

function Player:_updateTarget()
	local handX = math.floor(self:getHandPosition().x)
	local handY = math.floor(self:getHandPosition().y)
	local minSqrDistance = math.huge

	self.targetItem = nil
	beholder.trigger(Event.CHECK_IN_RANGE, handX, handY, self.pickingRadius,
		function(item, sqrDistance)
			if sqrDistance < minSqrDistance then
				minSqrDistance = sqrDistance
				self.targetItem = item
			end
		end)
	if self.targetItem then
		self.targetItem.glow = true
	end
end

function Player:onKeyReleased(key)
	if key == ' ' or key == 'j' then
		local item = self.holdingItem
		local sm = Game.SceneManager:getNowRunning().stickManager
		if item then -- put item
			self.ox = 16
			self.anims = R.anims.player()
			item.x = math.floor(self:getHandPosition().x)
			item.y = math.floor(self:getHandPosition().y)
			sm:addStick(item, nil) -- sitck only
			self.holdingItem = nil
		elseif self.targetItem then -- hold item
			self.ox = 36
			self.anims = R.anims.playerStick()
			if self.targetItem:is_a(Stick) then
				self.targetItem:removeSelf()
				self.holdingItem = self.targetItem
				sm:removeStick(self.targetItem)
			else
				self.targetItem:minusOneStick()
				self.holdingItem = sm:generateFireStick()
			end
		end
	end
end

function Player:getHandPosition()
	return { x = self.x + self:getDirVect().x * self.handLength,
	         y = self.y + self:getDirVect().y * self.handLength }
end

function Player:getDirVect()
	return Direction.toVect(self.dir)
end

function Player:pick(item)
	if self.holdingItem then
		return false
	else
		self.holdingItem = item
		return true
	end
end

function Player:getCurrentAnimIndex()
	return self.dir
end

return Player
