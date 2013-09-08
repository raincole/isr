require 'vendor/class'

local Scene_Base = class()

function Scene_Base:__init()
	self._screen = Screen()
end

function Scene_Base:update(dt)
	if Game.SceneManager.currentScene ~= self then
		self:dispose()
		return
	end

	self._screen:update(dt)
	self._screen:afterUpdate()
end

function Scene_Base:draw()
	self._screen:draw()
end

function Scene_Base:onMousePressed(x, y, button)
	self._screen:onMousePressed(x, y, button)
end

function Scene_Base:onMouseReleased(x, y, button)
	self._screen:onMouseReleased(x, y, button)
end

function Scene_Base:onKeyReleased(key)
	self._screen:onKeyReleased(key)
end

function Scene_Base:dispose()
	
end

return Scene_Base