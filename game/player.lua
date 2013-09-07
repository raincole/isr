require 'vendor/class'

local Player = class(Entity)

function Player:__init(name)
	self._base.__init(self, name)
	self.x = 0
	self.y = 0
	self.width = 32
	self.height = 32
	self.zIndex = 10

	self.speed = 80
	self.pickingRadius = 40
	self.handLength = 20
	self.dir = Direction.CENTER
	self.anims = R.anims.player
	self.targetItem = nil
	self.holdingItem = nil
end

function Player:update(dt)
	self:getCurrentAnim():update(dt)

	self:_handleMove(dt)
	self:_updateTarget()
end

function Player:_handleMove(dt)
	local dir = Direction.CENTER
	local keys = { 'up', 'right', 'down', 'left', 'w', 'd', 's', 'a' }
	for i, key in ipairs(keys) do
		if love.keyboard.isDown(key) then
			dir = Direction.comebine(dir, Direction.fromKey(key))
		end
	end

	if dir ~= Direction.CENTER then self.dir = dir end

	local vect = Direction.toVect(dir)
	self.x = self.x + vect.x * self.speed * dt
	self.y = self.y + vect.y * self.speed * dt
end

function Player:_updateTarget()
	local handX = self:getHandPosition().x
	local handY = self:getHandPosition().y
	local minSqrDistance = math.huge

	self.targetItem = nil
	beholder.trigger(Event.CHECK_IN_RANGE, handX, handY, self.pickingRadius,
		function(item, sqrDistance)
			if sqrDistance < minSqrDistance then
				minSqrDistance = sqrDistance
				self.targetItem = item
			end
		end)
end

function Player:onKeyReleased(key)
	if key == ' ' or key == 'j' then
		item = self.holdingItem
		if item then
			item.ox = self:getHandPosition().x
			item.oy = self:getHandPosition().y
			Game.currentScreen:addEntity(item)
			self.holdingItem = nil
		elseif self.targetItem then
			self.targetItem:removeSelf()
			self.holdingItem = self.targetItem
		end
	end
end

function Player:getOrigin()
	return { x = self.x + self.width / 2, y = self.y + self.height / 2 }
end

function Player:getHandPosition()
	local origin = self:getOrigin()
	return { x = origin.x + self:getDirVect().x * self.handLength,
	         y = origin.y + self:getDirVect().y * self.handLength }
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

function Player:draw()
	self:getCurrentAnim():draw(self.x, self.y)
end

function Player:getCurrentAnim()
	return self.anims[self.dir]
end

return Player
