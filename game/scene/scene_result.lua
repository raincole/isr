require 'vendor/class'

local Scene_Result = class(Scene_Base)

function Scene_Result:__init(info, canvas, result)
	Scene_Result._base.__init(self, info)
	self.translationAnim = 'fade'
	self.translation = 0.8

	self.canvas = canvas
	self.result = result
end

function Scene_Result:draw()
	love.graphics.draw(self.canvas)
	if self.result.status == 'win' then
		love.graphics.draw(R.images.result_Y)
	else
		love.graphics.draw(R.images.result_N)
	end

	Scene_Result._base.draw(self)
end

function Scene_Result:onKeyReleased(key)
	if key == ' ' then
		Game.SceneManager:switchScene(Scene_Game, R.levels[self.result.next])
	elseif key == 'escape' then
		Game.SceneManager:backScene()
	end

	Scene_Result._base.onKeyReleased(self, key)
end

return Scene_Result
