require 'vendor/class'

local Player = class(Entity)

function Player:__init(name)
	self._base.__init(self, name)
	self.x = 0
	self.y = 0
	self.speed = 80
	self.dir = Direction.CENTER
	self.anims = R.anims.player
end

function Player:update(dt)
	self:getCurrentAnim():update(dt)

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

function Player:draw()
	self:getCurrentAnim():draw(self.x, self.y)
end

function Player:getCurrentAnim()
	print(inspect(self.anims))
	return self.anims[self.dir]
end

return Player
