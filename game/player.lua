require 'vendor/class'

local Player = class(Entity)

function Player:__init(name)
	self._base.__init(self, name)
	self.x = 0
	self.y = 0
	self.width = 16
	self.height = 16
	self.speed = 80
	self.pickingRadius = 40
	self.dir = Direction.CENTER
	self.anims = R.anims.player
	self.holdingItem = nil
end

function Player:update(dt)
	self:getCurrentAnim():update(dt)

	self:_handleMove(dt)
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

function Player:onKeyReleased(key)
	if key == ' ' or key == 'j' then
		local origin = self:getOrigin()
		local item = self.holdingItem
		if item then
			item.ox = origin.x
			item.oy = origin.y
			Game.currentScreen:addEntity(item)
			self.holdingItem = nil
		else
			beholder.trigger(Event.TRY_PICK,
							 self, origin.x, origin.y, self.pickingRadius)
		end
	end
end

function Player:getOrigin()
	return { x = self.x + self.width / 2, y = self.y + self.height / 2 }
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
