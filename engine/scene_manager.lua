require 'vendor/class'

local SceneManager = class()

function SceneManager:__init(first)
	self.currentScene = first()
	self._nowRunning = nil
	self._sceneStack = {}
	self._canvas = nil
	self._canvas2 = nil
	table.insert(self._sceneStack, self.currentScene)
	self._translate = false
	self._translateTime = 0
	self._translating = 0
end

function SceneManager:getNowRunning()
	return self._nowRunning
end

function SceneManager:nextScene(next, time)
	self.currentScene = next()
	self._translateTime = time or 0
	self._translating = 0
end

function SceneManager:backScene(time)
	self.currentScene = nil
	self._translateTime = time or 0
	self._translating = 0
end

function SceneManager:switchScene(next, time)
	self:nextScene(next, time)
	table.remove(self._sceneStack)
end

function SceneManager:translate(percent)
	local quad = love.graphics.newQuad(0, 0, 
		love.graphics.getWidth(), 100 * precent, 
		love.graphics.getWidth(), love.graphics.getHeight()
	)
	love.graphics.drawq(self._canvas, quad, 0, 0, 0, 1, 1, 0, 0, 0, 100)
end

function SceneManager:_moveScene()
	if self.currentScene then
		table.insert(self._sceneStack, self.currentScene)
	else
		self.currentScene = table.remove(self._sceneStack)
	end
end

-- love2d events

function SceneManager:update(dt)
	if self._translate == true then
		if self._canvas2 == nil then
			self._nowRunning = self.currentScene
			self.currentScene:update(dt)
		end
		return
	end
	self._nowRunning = self.currentScene
	self.currentScene:update(dt)
end

function SceneManager:draw()
	if self._translate == true then
		if self._canvas2 == nil then
			self.currentScene:draw()
			self._canvas2 = love.graphics.newScreenshot()
		end
		if self:translate(self._translating / self._translateTime) then
			self._canvas = nil
			self._canvas2 = nil
			self._translate = false
		end
	end
	
	self.currentScene:draw()

	if self.currentScene == nil or 
		self.currentScene ~= self._sceneStack[#self._sceneStack] then
		self._canvas = love.graphics.newScreenshot()
		self._translate = true
		self:_moveScene()
	end
end

function SceneManager:onMousePressed(x, y, button)
	self.currentScene:onMousePressed(x, y, button)
end

function SceneManager:onMouseReleased(x, y, button)
	self.currentScene:onMouseReleased(x, y, button)
end

function SceneManager:onKeyReleased(key)
	self.currentScene:onKeyReleased(key)
end

return SceneManager