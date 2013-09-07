require 'vendor/class'

local Campfire = class(Entity)

function Campfire:__init(name, ox, oy)
    self._base.__init(self, name)
    self.images = R.images.campfires
    self.ox = ox
    self.oy = oy
    self.width = self.images.normal:getWidth()
    self.height = self.images.normal:getHeight()
    self.zIndex = 0

    self.timer = Timer(10)

    self.barbsLimitNum = 5
    self.barbsBeingNum = 0

end

function Campfire:registerObservers()
    -- TODO: 監聽樹枝掉在附近的事件
end

function Campfire:update(dt)
    if self.timer:isTimeUp() == true then
        self._base.removeSelf()
    end

    -- TODO: 判定附近固定範圍是否有樹枝，有的話就吃掉，增加營火的生命期限。

    -- Q: 如何偵測附近一定範圍有barbs? 
    -- A: 由野蠻人觸發營火的函數去改變數量。所以相關程式碼請參照野蠻人的程式碼。
end

function Campfire:draw()

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