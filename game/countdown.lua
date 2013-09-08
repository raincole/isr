--countdown timer 

require 'vendor/class'

local Countdown = class(Entity)

function Countdown:__init(gameTime)
    self._base.__init(self, name)
    self.timer = Timer("countdown", gameTime)
    self.images = R.images.sceneCountdwon
end


function Countdown:draw()

    if self.timer:isTimeUp() == false then
        love.graphics.printf( string.format("%.1f",self.timer:getRemainTime()), 10, 10, 100, "left" )
    else 
        love.graphics.printf( "time is up" , 10, 10, 100, "left" )
    end
    love.graphics.draw( self.images[1], 10, love.graphics.getHeight() - 30)

end

return Countdown
