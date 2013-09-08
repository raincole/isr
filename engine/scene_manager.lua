require 'vendor/class'

local SceneManager = class()

function SceneManager:__init(first)
	self.currentScene = first
	self._nowRunning = nil
	self._sceneStack = {}
	self._canvas = nil
	self._canvas2 = nil
	table.insert(self._sceneStack, self.currentScene)
	self._translate = false
	self._translateTime = 0
	self._translating = 0

	self.translateBlockHeight = 20
end

function SceneManager:getNowRunning()
	return self._nowRunning
end

function SceneManager:nextScene(next, time)
	self.currentScene = next
	self._translateTime = time
	self._translating = 0
end

function SceneManager:backScene(time)
	self.currentScene = nil
	self._translateTime = time
	self._translating = 0
end

function SceneManager:switchScene(next, time)
	self:nextScene(next, time)
	table.remove(self._sceneStack)
end

function SceneManager:translate()
	local percent = 1 - self._translating / self._translateTime

	love.graphics.draw(self._canvas2, 0, 0)

	for i = 0, math.floor(love.graphics.getHeight() / self.translateBlockHeight) do
		local quad = love.graphics.newQuad(0, i * self.translateBlockHeight, 
			love.graphics.getWidth(), self.translateBlockHeight * percent, 
			love.graphics.getWidth(), love.graphics.getHeight()
		)
		love.graphics.drawq(self._canvas, quad, 0, i * self.translateBlockHeight)
	end
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
		self._translating = self._translating + dt
		if self._translating > self._translateTime then
			self._translate = false
		end
		return
	end
	self._nowRunning = self.currentScene
	self.currentScene:update(dt)
	if self.currentScene == nil or 
		self.currentScene ~= self._sceneStack[#self._sceneStack] then
		self:_moveScene()
		if self._translateTime > 0 then
			self._translate = true
		end
	end
end

function SceneManager:draw()

	if self._translate then
		if self._canvas == nil then
			self._canvas = love.graphics.newCanvas()
			self._canvas2 = love.graphics.newCanvas()
			self._canvas:renderTo(function()
				local r, g, b, a = love.graphics.getColor()
				love.graphics.setColor(0, 0, 0, 255)
				love.graphics.rectangle("fill", 0, 0,
					love.graphics.getWidth(), love.graphics.getHeight())
				love.graphics.setColor(r, g, b, a)
				self._nowRunning:draw()
			end)
			self._canvas2:renderTo(function()
				self.currentScene:draw()
			end)
		end
		self:translate()
		return
	end
	
	self.currentScene:draw()
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