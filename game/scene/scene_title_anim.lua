require 'vendor/class'

local Scene_TitleAnim = class(Scene_Base)
local newImage = love.graphics.newImage

function Scene_TitleAnim:__init(info)
	Scene_TitleAnim._base.__init(self, info)

	self.title = newImage('assets/images/opening/title.png')
	self.mapA  = newImage('assets/images/opening/map_0.png')
	self.mapB  = newImage('assets/images/opening/map_1.png')
	self.ballons = {}
	for i = 1, 25 do
		self.ballons[i] = newImage('assets/images/opening/ballons/OP_' .. string.format("%03d.png", i))
	end
	self.ballonsLoaded = 25

	self.fps = 60
	self.timer = 0
	self.frame = 0
	self.step = 1
	self.spf = 1 / self.fps

	self.title_opacity = 255
	Game.globalStroage.bgm = R.musics.menu
	love.audio.play(Game.globalStroage.bgm)
end

function Scene_TitleAnim:update(dt)
	local frame = 0
	self.timer = self.timer + dt
	if self.timer > self.spf then
		frame = math.floor(self.timer / self.spf)
		self.timer = self.timer % self.spf
	end

	if self.step == 1 then
		self:aniStep1(frame)
	elseif self.step == 2 then
		self:aniStep2(frame)
	elseif self.step == 3 then
		self:aniStep3(frame)
	elseif self.step == 4 then
		self:aniStep4(frame)
	elseif self.step == 5 then
		self:aniStep5(frame)
	end

	if self.ballonsLoaded < 134 then
		self.ballonsLoaded = self.ballonsLoaded + 1
		self.ballons[self.ballonsLoaded] = newImage('assets/images/opening/ballons/OP_' .. string.format("%03d.png", self.ballonsLoaded))
	end

	Scene_TitleAnim._base.update(self, dt)
end

function Scene_TitleAnim:draw()
	if self.step == 1 then
		self:aniDraw1()
	elseif self.step == 2 then
		self:aniDraw2()
	elseif self.step == 3 then
		self:aniDraw3()
	elseif self.step == 4 then
		self:aniDraw4()
	elseif self.step == 5 then
		self:aniDraw5()
	end

	Scene_TitleAnim._base.draw(self, dt)
end

function Scene_TitleAnim:onKeyReleased(key)
	if key == ' ' then
		Game.SceneManager:switchScene(Scene_Title)
	end

	Scene_TitleAnim._base.onKeyReleased(self, key)
end

function Scene_TitleAnim:aniStep1(frame)
	self.title_opacity = self.title_opacity + frame * 2
	if self.title_opacity >= 255 then
		self.frame = self.frame + frame
		if self.frame > 120 then
			self.title_opacity = 255
			self.map_opacity = 0
			self.step = 2
		end
	end
end

function Scene_TitleAnim:aniDraw1()
	local r, g, b, a = love.graphics.getColor()
	local o = self.title_opacity
	if o > 255 then o = 255 end
	love.graphics.setColor(255, 255, 255, self.title_opacity)
	love.graphics.draw(self.title,
		(love.graphics.getWidth() - self.title:getWidth()) / 2,
		(love.graphics.getHeight() - self.title:getHeight()) / 2)
	love.graphics.setColor(r, g, b, a)
end

function Scene_TitleAnim:aniStep2(frame)
	self.title_opacity = self.title_opacity - frame * 2
	if self.title_opacity < 0 then self.title_opacity = 0 end
	self.map_opacity = self.map_opacity + frame * 2
	if self.map_opacity > 255 then
		self.map_opacity = 255
		self.ballonFrame = 1
		self.ballonTimer = 0
		self.step = 3
	end
end

function Scene_TitleAnim:aniDraw2()
	local r, g, b, a = love.graphics.getColor()
	local o = 0

	o = self.map_opacity
	love.graphics.setColor(255, 255, 255, self.map_opacity)
	love.graphics.draw(self.mapA)


	o = self.title_opacity
	love.graphics.setColor(255, 255, 255, self.title_opacity)
	love.graphics.draw(self.title,
		(love.graphics.getWidth() - self.title:getWidth()) / 2,
		(love.graphics.getHeight() - self.title:getHeight()) / 2)

	love.graphics.setColor(r, g, b, a)
end

function Scene_TitleAnim:aniStep3(frame)
	self.ballonTimer = self.ballonTimer + frame
	if self.ballonTimer >= 3 then
		self.ballonFrame = self.ballonFrame + 1
		self.ballonTimer = 0
	end
	if self.ballonFrame > 134 then
		self.ballonFrame = 134
		self.map_opacity = 0
		self.step = 4
	end
end

function Scene_TitleAnim:aniDraw3()
	love.graphics.draw(self.mapA)
	love.graphics.draw(self.ballons[self.ballonFrame], 364, 0)
end

function Scene_TitleAnim:aniStep4(frame)
	self.map_opacity = self.map_opacity + frame * 5
	if self.map_opacity > 255 then
		self.step = 5
	end
end

function Scene_TitleAnim:aniDraw4()
	love.graphics.draw(self.mapA)

	local r, g, b, a = love.graphics.getColor()
	local o = 0

	o = self.map_opacity
	love.graphics.setColor(255, 255, 255, self.map_opacity)
	love.graphics.draw(self.mapB)

	love.graphics.setColor(r, g, b, a)

	love.graphics.draw(self.ballons[#self.ballons], 364, 0)
end


function Scene_TitleAnim:aniStep5(frame)
	Game.SceneManager:switchScene(Scene_Title)
end

function Scene_TitleAnim:aniDraw5()
	love.graphics.draw(self.mapB)
	love.graphics.draw(self.ballons[#self.ballons], 364, 0)
end

return Scene_TitleAnim
