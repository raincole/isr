require 'vendor/class'

local Emotion = class(Entity)

function Emotion:__init(name, x, y, metadata)
    Emotion._base.__init(self, name)
    self.x = math.floor(x)
    self.y = math.floor(y)
    self.ox = metadata.ox
    self.oy = metadata.oy
    self.image = metadata.img
    self.frame = 0
    self.during = metadata.during
    self.zIndex = 80
end
    
function Emotion:update(dt)
    if self.frame > self.during + 3 then
        self:removeSelf()
        return
    end
    self.frame = self.frame + dt * 60
end

function Emotion:draw()
    love.graphics.draw(self.image, self.x - self.ox, self.y - self.oy - math.min(math.floor(self.frame) ,3))
end

return Emotion
