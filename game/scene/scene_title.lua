require 'vendor/class'

local Scene_Title = class(Scene_Base)

function Scene_Title:__init()
	Scene_Title._base.__init(self)
end

function Scene_Title:update(dt)
	Game.SceneManager:nextScene(Scene_Game(R.levels[1]), 1)

	Scene_Title._base.update(self, dt)
end

return Scene_Title
