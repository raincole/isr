require 'vendor/class'

local Player = class(Entity)

function Player:__init(name)
	self._base.__init(self, name)
	self.x = 0
	self.y = 0
	self.anim = R.anims.player.up
end

function Player:update(dt)
	self.anim:update(dt)
end

function Player:draw()
	self.anim:draw(self.x, self.y)
end

return Player
