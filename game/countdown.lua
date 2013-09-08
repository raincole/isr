--countdown timer 

require 'vendor/class'

local Countdown = class(Entity)

function Countdown:__init(gameTime)
    self._base.__init(self, name)
    self.timer = Timer("countdown", gameTime)
    self.images = R.images.countdown.scene
    self.zIndex = 100
end


function Countdown:draw()

    if self.timer:isTimeUp() == false then
        love.graphics.printf( string.format("%.1f / %.1f",self.timer:getRemainTime(), self.timer:getLifeTime()),
            10, 10, 100, "left" )
    else 
        love.graphics.printf( "time is up" , 10, 10, 100, "left" )
    end
    
    love.graphics.draw( self.images[2], 10, love.graphics.getHeight() - 30)

    proportion = self.timer:getRemainTime() / self.timer:getLifeTime()
    if proportion < 0 then proportion = 0 end
    quad = love.graphics.newQuad(0,0,151*proportion,7,151,7)
    love.graphics.drawq(self.images[3], quad, 47, love.graphics.getHeight() - 23)

end

return Countdown
