require 'vendor/class'

local Campfire = class(Animator)

function Campfire:__init(name, x, y)
    Campfire._base.__init(self, name, R.anims.campfire())
    self.x = x
    self.y = y
    self.ox = 23
    self.oy = 39
    self.lightRadius = 30
    self.zIndex = 10
    self.barbs = {}

    self.timer = Timer('campfire_timer', 10)

    self.barbsLimitNum = 5
    self.barbsBeingNum = 0

    self.radius = 15
end

function Campfire:registerObservers()
    beholder.observe(Event.PUT_STICK_ON_GROUND, function(stick, cb)
        if stick.toRemove == true then return end
        local sqrDistance = (self.x - stick.x) * (self.x - stick.x) + (self.y - stick.y) * (self.y - stick.y)
        if sqrDistance <= self.radius * self.radius then
            self:changeLifeTime(R.metadatas.campfire.oneStickLifespan)
            cb()
        end
    end)
end

function Campfire:update(dt)
    Campfire._base.update(self, dt)

    if self.timer:isTimeUp() == true then
        self:extinguish()
    else
        beholder.trigger(Event.CAMPFIRE, self.x, self.y, self.lightRadius, function(barb)
            if not self:isFull() then
                barb:findCampfire()
                table.insert(self.barbs, barb)
            end
        end)
    end
end

function Campfire:draw()
    Campfire._base.draw(self)
    -- TODO: 營火生命週期血條
    --       血條從正中間為抵，時間越長越往兩側伸展，反之則越往中間縮短

    -- TODO: 營火圖案
    --       love.graphics.draw(self.images.normal, self.ox - self.width / 2, self.oy - self.height / 2)
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

function Campfire:isFull()
    if #self.barbs < self.barbsLimitNum then
        return false
    else
        return true
    end
end

return Campfire
