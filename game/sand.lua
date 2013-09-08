require 'vendor/class'

local Sand = class(Entity)

function Sand:__init(name, x, y)
    Sand._base.__init(self, name)
    self.x = math.floor(x)
    self.y = math.floor(y)
    self.width = 52
    self.height = 52
    self.ox = 1
    self.oy = 1
    self.zIndex = 10
    self.images = R.images.sand
    self.rand = math.random(6)
    self.radius = 35
end

function Sand:update(dt)
    beholder.trigger(Event.HERE_IS_SAND, self.x, self.y, self.width, self.height)    
end

function Sand:draw()
    quad = love.graphics.newQuad(52*(self.rand-1), 0, self.width, self.height, 312, 52)
    love.graphics.drawq(self.images, quad, self.x, self.y)
end

function Sand:getRect()
    return Rect(self.x, self.x, self.width, self.height)
end

return Sand
