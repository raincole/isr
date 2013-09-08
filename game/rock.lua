require 'vendor/class'

local Rock = class(Entity)

function Rock:__init(name, x, y)
    Rock._base.__init(self, name)
    self.x = math.floor(x)
    self.y = math.floor(y)
    self.width = 50
    self.height = 50
    self.ox = 26
    self.oy = 26
    self.zIndex = 10
    self.images = R.images.rock
    self.rand = math.random(6)
    self.radius = 35
end

function Rock:registerObservers()
    beholder.observe(Event.PUT_STICK_ON_GROUND, function(stick, cb)
        if stick.toRemove == true then return end
        local selfX = self.x
        local selfY = self.y
        local sqrDistance = (selfX - stick.x) * (selfX - stick.x) + (selfY - stick.y) * (selfY - stick.y)
        if sqrDistance <= self.radius * self.radius  then
            cb()
        end
    end)    
    beholder.observe(Event.TRY_TO_MOVE, function(rect, velocity, callback)
        callback(rect:collisionTime(self:getRect(), velocity))
    end)
end

function Rock:draw()
    quad = love.graphics.newQuad(52 * (self.rand-1), 0, 52, 52, 312, 52)
    love.graphics.drawq(self.images, quad, self.x - self.ox, self.y - self.oy)
end

function Rock:getRect()
    return Rect(self.x - self.width / 2, self.y - self.height / 2, self.width, self.height)
end

return Rock
