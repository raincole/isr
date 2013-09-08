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
	local anim = self:getCurrentAnim()
	if anim then self:getCurrentAnim():update(dt) end
end

function Animator:draw()
	local anim = self:getCurrentAnim()
	if anim then anim:draw(self.x - self.ox, self.y - self.oy) end
end

function Animator:getCurrentAnim()
	return self.anims[self:getCurrentAnimIndex()]
end

function Animator:getCurrentAnimIndex()
	return 1
end

function Animator:getRect()
    return Rect(self.x - self.width / 2, self.y - self.height / 2,
                self.width, self.height)
end

function Animator:tryToMove(dir, length)
	local rect = self:getRect()
	local firstCollisionTime = 1
	local velocity = dir:stretchTo(length)

	beholder.trigger(Event.TRY_TO_MOVE, rect, velocity, function(collisionTime)
		firstCollisionTime = math.min(firstCollisionTime, collisionTime)
	end)

	local displacement = velocity:scale(firstCollisionTime)
	self.x = self.x + displacement.x
	self.y = self.y + displacement.y
	return displacement
end

return Animator
