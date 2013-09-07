--timer 
require 'vendor/class'

local Timer = class()

function Timer:__init(name, lifeTime)

    self.name = name
    self.lifeTime = lifeTime
    self.passTime = 0
    self.remainTime = lifeTime
    self.timeUp = false

    Game.timerManager:addTimer(self)
end

function Timer:update(dt)

    self.passTime = self.passTime + dt
    self.remainTime = self.lifeTime - self.passTime

    if self.timeUp == false and self.remainTime <= 0 then
        self.timeUp = true
    end
end

function Timer:isTimeUp()
    return self.timeUp
end

function Timer:getLifeTime()
    return self.lifeTime
end

function Timer:getPassTime()
    return self.passTime
end

function Timer:getRemainTime()
    return self.remainTime
end


return Timer
