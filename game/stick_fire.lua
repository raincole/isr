require 'vendor/class'

local StickFire = class(Animator)

function StickFire:__init(name, x, y)
	StickFire._base.__init(self, name, R.anims.stickfire())
	self.x = math.floor(x)
	self.y = math.floor(y)
	self.ox = 6
	self.oy = 26
	self.width = 12
	self.height = 26
	self.zIndex = 2
end

return StickFire
