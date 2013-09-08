require 'vendor/class'

local Scene_Title = class(Scene_Base)

function Scene_Title:__init(info, item)
	Scene_Title._base.__init(self, info)
	self.translationAnim = 'fade'
	self.translation = 0.6

	self.item = item or 1
	self.unlock = 10
	if self.item > 10 then self.item = 10 end
	if self.item < 1  then self.item = 1  end
	self.map = R.images.title.map
	self.map_ALL = R.images.title.mapALL
	self.man = R.images.title.man
	self.locks = R.images.title.barbs
end

function Scene_Title:draw()
	if self.unlock <= 10 then
		love.graphics.draw(self.map)
	else
		love.graphics.draw(self.map_ALL)
	end
	love.graphics.draw(self.man,
		R.metadatas.title.stagePosition[self.item].x - R.metadatas.title.manOffset.x,
		R.metadatas.title.stagePosition[self.item].y - R.metadatas.title.manOffset.y)

	if self.unlock < 10 then
		for i = self.unlock + 1, 10 do
			love.graphics.draw(self.locks[i % 3 + 1], 
				R.metadatas.title.stagePosition[i].x - R.metadatas.title.barbOffset.x,
				R.metadatas.title.stagePosition[i].y - R.metadatas.title.barbOffset.y)
		end
	end

	Scene_Title._base.draw(self)
end

function Scene_Title:resume(item, unlock)
	if item then
		self.item = item
	end
	if unlock then
		if self.unlock < unlock then
			self.unlock = unlock
		end
	end
end

function Scene_Title:onKeyReleased(key)
	if key == ' ' then
		if self.item == 1 then
			Game.SceneManager:nextScene(Scene_Tutorial)
		else
			Game.SceneManager:nextScene(Scene_Game, R.levels[self.item])
		end
	elseif key == 'up' or key == 'w'
		or key == 'down' or key == 's' then
		local canvas = love.graphics.newCanvas()
		canvas:renderTo(function()
			self:draw()
		end)
		Game.SceneManager:nextScene(Scene_Credit, canvas)
	elseif key == 'left' or
		key == 'a' then
		self.item = self.item + 1
	elseif key == 'right' or
		key == 'd' then
		self.item = self.item - 1
	end

	if self.item > self.unlock then self.item = self.unlock end
	if self.item > 10 then self.item = 10 end
	if self.item < 1  then self.item = 1  end

	Scene_Title._base.onKeyReleased(self, key)
end

return Scene_Title
