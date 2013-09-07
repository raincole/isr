require 'vendor/class'

local Campfire = class(Animator)

function Campfire:__init(name, x, y)
    Campfire._base.__init(self, name, R.anims.campfire())
    self.x = x
    self.y = y
    self.ox = 23
    self.oy = 39
    self.zIndex = 1

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
    if self.timer:isTimeUp() == true then
        self:removeSelf()
    end
    
    Campfire._base.update(self, dt)

    -- Q: 如何偵測附近一定範圍有barbs? 
    -- A: 由野蠻人觸發營火的函數去改變數量。所以相關程式碼請參照野蠻人的程式碼。
end

function Campfire:draw()
    Campfire._base.draw(self)
    -- TODO: 營火生命週期血條
    --       血條從正中間為抵，時間越長越往兩側伸展，反之則越往中間縮短

    -- TODO: 營火圖案
    --       love.graphics.draw(self.images.normal, self.ox - self.width / 2, self.oy - self.height / 2)
end


function Campfire:changeLifeTime(seconds)
    self.timer:changeLifeTime(seconds)
end

function Campfire:isBeingFull()
    if self.barbsBeingNum < self.barbsLimitNum then
        return false
    else
        return true
    end
end

function Campfire:changeBarbsBeingNum(number)
    self.barbsBeingNum = self.barbsBeingNum + number

    if self.barbsBeingNum < 0 then
        error("Number of barbarian near campfire is Error!!!")
    end
end

return Campfire