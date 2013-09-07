--countdown timer 

require 'vendor/class'

local Countdown = class(Entity)

function Countdown:__init(gameTime)
    self._base.__init(self, name)
    self.timer = Timer("countdown", gameTime)
    self.timeUp = false
end

function Countdown:update(dt)
    if self.timeUp == false and self.timer:getRemainTime() <= 0 then
        self.timeUp = true
    end
end

function Countdown:draw()

    if self.timeUp == false then
        love.graphics.printf( string.format("%.1f",self.timer:getRemainTime()), 10, 10, 100, "left" )
    else 
        love.graphics.printf( "time is up" , 10, 10, 100, "left" )
    end
end

return Countdown
