require 'vendor/class'

local Button = class(Entity)

function Button:__init(options, x, y)
	self._base.__init(self)

	self.onPressed = options.onPressed
	self.onReleased = options.onReleased
	self.onImage = options.onImage
	self.pressingImage = options.pressingImage
	self.offImage = options.offImage
	self.prediction = options.checkOn or function() return true end
	self.once = options.once

	self.x = x
	self.y = y
	self.status = 'off'
	self.visible = true
end

function Button:getImage()
	local image
	if self.status == 'on' then image = self.onImage
	elseif self.status == 'pressing' then image = self.pressingImage
	elseif self.status == 'off' then image = self.offImage
	else image = nil
	end

	return image
end

function Button:getRect()
	local image = self:getImage()
	if image then
		return Rect(self.x, self.y, image:getWidth(), image:getHeight())
	else
		return Rect(0, 0, 0, 0)
	end
end

function Button:show()
	self.visible = true
end

function Button:hide()
	self.visible = false
end

function Button:draw()
	local image = self:getImage()
	if self.visible and image then love.graphics.draw(image, self.x, self.y) end
end

function Button:update()
	if self.status == 'off' and self:prediction() then
		self.status = 'on'
	elseif self.status == 'on' and not self:prediction() then
		self.status = 'off'
	end
end

function Button:onMousePressed(x, y, button)
	if button == 'l' then
		if self.visible and self.status == 'on' and self:getRect():contains(x, y) then
			if type(self.onPressed) == 'function' then
				self:onPressed()
				if self.once then self:removeSelf() end
				return true
			end
		end
	end
	return false
end

return Button
