--timer manager

require 'vendor/class'

local TimerManager = class()

function TimerManager:__init()
    self.timerList = {}

end

function TimerManager:draw()

end

function TimerManager:update(dt)
    for i, t in ipairs(self.timerList) do
        t:update(dt)
    end
end

function TimerManager:addTimer(timer)
    table.insert(self.timerList, timer)
end

function TimerManager:addTimers(timers)
    for i, t in ipairs(timers) do
        self:addTimer(t)
    end
end

return TimerManager
