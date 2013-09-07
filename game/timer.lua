require 'vendor/class'

local Timer = class(Entity)


function Timer:__init(name, remain_time)
    self._base.__init(self, name)
    self.remain_time = remain_time
    self.time_up = false
end

function Timer:update(dt)
    if self.time_up == false then
        self.remain_time = self.remain_time - dt
        if self.remain_time <= 0 then
            self.time_up = true
        end
    end
end

function Timer:draw()
    if self.time_up == false then
        love.graphics.printf( string.format("%.1f",self.remain_time), 10, 10, 100, "left" )
    else 
        love.graphics.printf( "time is up" , 10, 10, 100, "left" )
    end
end

return Timer
