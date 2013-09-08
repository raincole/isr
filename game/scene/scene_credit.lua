require 'vendor/class'

local Scene_Credit = class(Scene_Base)

function Scene_Credit:__init(info, canvas)
	Scene_Result._base.__init(self, info)
	self.translationAnim = 'slideFromUp'
	self.translation = 1

	self.canvas = canvas
	self.started = false
end

function Scene_Credit:update(dt)
	self.started = true

	Scene_Credit._base.update(self, dt)
end

function Scene_Credit:draw()
	if self.started then
		love.graphics.draw(self.canvas)
	end
	love.graphics.draw(R.images.CREDIT)
end

function Scene_Credit:onKeyReleased(key)
	if key == 'up' or key == 'down' then
		self.started = false
		Game.SceneManager:backScene()
	end

	Scene_Credit._base.onKeyReleased(self, key)
end

return Scene_Credit
