require 'vendor/class'

local Scene_Title = class(Scene_Base)

function Scene_Title:__init(info, item)
	Scene_Title._base.__init(self, info)

	self.translation = 0

	self.item = item or 1
	if self.item > 10 then self.item = 10 end
	if self.item < 1  then self.item = 1  end
	self.map = R.images.title.map
	self.man = R.images.title.man

end

function Scene_Title:draw()
	love.graphics.draw(self.map)
	love.graphics.draw(self.man,
		R.metadatas.title.stagePosition[self.item].x - R.metadatas.title.manOffset.x,
		R.metadatas.title.stagePosition[self.item].y - R.metadatas.title.manOffset.y)

	Scene_Title._base.draw(self)
end

function Scene_Title:onKeyReleased(key)
	if key == ' ' then
		Game.SceneManager:nextScene(Scene_Game, R.levels[1])
	elseif key == 'left' or
		key == 'a' then
		self.item = self.item + 1
	elseif key == 'right' or
		key == 'd' then
		self.item = self.item - 1
	end

	if self.item > 10 then self.item = 10 end
	if self.item < 1  then self.item = 1  end

	Scene_Title._base.onKeyReleased(self, key)
end

return Scene_Title
