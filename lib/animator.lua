require 'vendor/class'

local Animator = class(Entity)

function Animator:__init(name, anims)
	Animator._base.__init(self, name)
	self.anims = anims
	self.x = 0
	self.y = 0
	self.ox = 0
	self.oy = 0
end

function Animator:update(dt)
	self:getCurrentAnim():update(dt)
end

function Animator:draw()
	self:getCurrentAnim():draw(self.x - self.ox, self.y - self.oy)
end

function Animator:getCurrentAnim()
	return self.anims[self:getCurrentAnimIndex()]
end

function Animator:getCurrentAnimIndex()
	return 1
end

return Animator
