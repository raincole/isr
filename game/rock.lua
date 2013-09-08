require 'vendor/class'

local Rock = class(Entity)

function Rock:__init(name, x, y)
    Rock._base.__init(self, name)
    self.x = math.floor(x)
    self.y = math.floor(y)
    self.width = 52
    self.height = 52
    self.ox = 1
    self.oy = 1
    self.zIndex = 10
    self.images = R.images.rock
    self.rand = math.random(6)
end

function Rock:registerObservers()
    beholder.observe(Event.TRY_TO_MOVE, function(rect, velocity, callback)
        callback(rect:collisionTime(self:getRect(), velocity))
    end)
end

function Rock:update(dt)
    Rock._base.update(self, dt)
end

function Rock:draw()
    
    quad = love.graphics.newQuad(52*(self.rand-1), 0, self.width, self.height, 312, 52)
    love.graphics.drawq(self.images, quad, self.x, self.y)
end

function Rock:getRect()
    return Rect(self.x, self.x, self.width, self.height)
end

return Rock
