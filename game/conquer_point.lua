require 'vendor/class'

local ConquerPoint = class(Entity)

function ConquerPoint:__init(name, scene)
    ConquerPoint._base.__init(self, name)
    self.imgIcon = R.images.conquerPoint[1]
    self.imgEmptyPoint = R.images.conquerPoint[2]
    self.imgGetPoint = R.images.conquerPoint[3]
    self.conquerReached = 0
    self.conquerTarget = 0

    self.x = love.graphics.getWidth() - 42
    self.y = love.graphics.getHeight() - 37
    self.ox = self.imgIcon:getWidth() / 2
    self.oy = self.imgIcon:getHeight() / 2
    self.pointX = self.imgGetPoint:getWidth() / 2
    self.pointY = -self.imgGetPoint:getHeight() / 2 
    self.scene = scene
    self.zIndex = 100

end

function ConquerPoint:draw()
    love.graphics.draw( self.imgIcon, self.x, self.y)

    self.conquerReached = self.scene.colonizedBarbariansNum
    self.conquerTarget = self.scene.level.target
    for i=1, self.conquerTarget do
        if i <= self.conquerReached then
            love.graphics.draw(self.imgGetPoint, self.x - 10*i, self.y, 0, 1, 1, self.pointX, self.pointY)
        else
            love.graphics.draw(self.imgEmptyPoint, self.x  - 10*i, self.y, 0, 1, 1, self.pointX, self.pointY)
        end
    end
end

return ConquerPoint
