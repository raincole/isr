require 'vendor/class'

local Campfire = class(Animator)

function Campfire:__init(name, x, y, sticksNum)
    Campfire._base.__init(self, name, R.anims.campfire())
    self.x = math.floor(x)
    self.y = math.floor(y)
    self.width = 26
    self.height = 10
    self.ox = 26
    self.oy = 39
    self.lightRadius = 30
    self.zIndex = 10
    self.barbs = {}

    self.timer = Timer('campfire_timer', sticksNum * R.metadatas.campfire.oneStickLifespan / 2)
    self.lifeImage = R.images.countdown.campfire

    self.barbsLimitNum = 5
    self.barbsBeingNum = 0

    self.radius = R.metadatas.fire.burnRadius
end

function Campfire:registerObservers()
    beholder.observe(Event.CHECK_IN_RANGE, function(x, y, radius, callback)
        local sqrDistance = (self.x - x) * (self.x - x) + (self.y - y) * (self.y - y)
        if sqrDistance <= radius * radius then
            callback(self, sqrDistance)
        end
    end)
    beholder.observe(Event.PUT_STICK_ON_GROUND, function(stick, cb)
        if stick.toRemove == true then return end
        local sqrDistance = (self.x - stick.x) * (self.x - stick.x) + (self.y - stick.y) * (self.y - stick.y)
        if sqrDistance <= self.radius * self.radius then
            self:addOneStick()
            cb()
        end
    end)
    beholder.observe(Event.TRY_TO_MOVE, function(rect, velocity, callback)
        callback(rect:collisionTime(self:getRect(), velocity))
    end)
end

function Campfire:update(dt)
    Campfire._base.update(self, dt)

    if self.timer:isTimeUp() == true then
        Game.SceneManager:getNowRunning().stickManager:changeBurningStickNum(-1)
        self:extinguish()
    else
        beholder.trigger(Event.CAMPFIRE, self.x, self.y, self.lightRadius, function(barb)
            if not self:isFull() then
                barb:findCampfire()
                table.insert(self.barbs, barb)
            end
        end)
    end
    self.glow = false
end

function Campfire:draw()
    Campfire._base.draw(self)

    love.graphics.printf( string.format("%.1f",self.timer:getRemainTime()),
        self.x , self.y + 10 , 100, "left" )

    proportion = self.timer:getRemainTime() / self.timer:getLifeTime()
    if proportion < 0 then proportion = 0 end

    width = self.lifeImage:getWidth();
    height = self.lifeImage:getHeight();
    quad = love.graphics.newQuad(0, 0, width*proportion, height, width, height)
    love.graphics.draw( self.lifeImage, self.x - width*proportion*0.5 , self.y - self.oy - 10, 0, proportion, 1)
end

function Campfire:extinguish()
    for i, b in ipairs(self.barbs) do
        b:loseCampfire()
    end
    self:removeSelf()
end

function Campfire:changeLifeTime(seconds)
    self.timer:changeLifeTime(seconds)
end

function Campfire:minusOneStick()
    self:changeLifeTime(-R.metadatas.campfire.oneStickLifespan/2)
end

function Campfire:addOneStick()
    self:changeLifeTime(R.metadatas.campfire.oneStickLifespan/2)
end

function Campfire:isFull()
    if #self.barbs < self.barbsLimitNum then
        return false
    else
        return true
    end
end

function Campfire:getCurrentAnimIndex()
    if self.glow then return 'glow'
    else return 'normal' end
end

return Campfire
