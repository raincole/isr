require 'vendor/class'

local Thounder = class(Animator)

function Thounder:__init(name, x, y)
    Thounder._base.__init(self, name, R.anims.thounder())
    self.x = x
    self.y = y
    self.ox = 21
    self.oy = 600
    self.zIndex = 100
end

function Thounder:update(dt)
    if self:getCurrentAnim().position == 4 then
        self:removeSelf();
    end
    Thounder._base.update(self, dt)
    

end

return Thounder
