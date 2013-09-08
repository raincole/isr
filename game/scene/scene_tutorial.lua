require 'vendor/class'

local Scene_Tutorial = class(Scene_Base)

function Scene_Tutorial:__init(info)
	local tm = TimerManager()
	tm.update = function() end
	Scene_Tutorial._base.__init(self, {TM = tm})

	self.phrase = 'you'

	local player = Player('player')
	player.x = 398
	player.y = 310
	self._screen:addEntity(player)
	self.player = player
	self.playerUpdate = player.update
	player.update = function () end

	self.stickManager = StickManager("stickManager")
	self._screen:addEntity(self.stickManager)
	local stick = Stick('tutorial_fired_stick', 200, 310)
	stick.burnTime = 10000000000
	stick:getFired()
	self.stickManager:addStick(stick)

	local s1 = Stick('tutorial_stick1', 610, 300)
	local s2 = Stick('tutorial_stick2', 613, 302)
	local s3 = Stick('tutorial_stick3', 611, 296)
	local s4 = Stick('tutorial_stick4', 608, 298)
	self.stickManager:addStick(s1)
	self.stickManager:addStick(s2)
	self.stickManager:addStick(s3)
	self.stickManager:addStick(s4)

	local b1 = Barbarian('tutorial_barbarian1')
	b1.x = 610
	b1.y = 215
	local b2 = Barbarian('tutorial_barbarian2')
	b2.x = 610
	b2.y = 385
	self._screen:addEntity(b1)
	self._screen:addEntity(b2)
	self.b1 = b1
	self.b2 = b2

	self.colonizedBarbariansNum = 0
	beholder.observe(Event.CHANGE_COLONIZED_BARBARIANS, function(n)
		self.colonizedBarbariansNum = self.colonizedBarbariansNum + n
	end)
	self.level = {target = 2}

	local leftBorder = Border('leftBorder', Rect(-20, -20, 10, 1000))
	local rightBorder = Border('rightBorder', Rect(820, -20, 10, 1000))
	local upBorder = Border('upBorder', Rect(-20, -20, 1000, 10))
	local downBorder = Border('downBorder', Rect(-20, 620, 1000, 10))
	self._screen:addEntities({leftBorder, rightBorder, upBorder, downBorder})

	-- panel

	self.countdown = Countdown(10000000000)
	self._screen:addEntity(self.countdown)
	self._screen:addEntity(ConquerPoint("conquerPoint", self))

	love.audio.stop(Game.globalStroage.bgm)
	Game.globalStroage.bgm = R.musics.level
	love.audio.play(Game.globalStroage.bgm)
end

function Scene_Tutorial:update(dt)
	if self.countdown.timer:isTimeUp() then
		local canvas = love.graphics.newCanvas()
		canvas:renderTo(function()
			self:draw()
		end)

		Game.SceneManager:switchScene(Scene_Result,
			canvas, { status = 'lose', next = 1 }
		)
	end

	beholder.trigger(Event.LIGHT_SOURCE, 610, 300, 90)

	if self.phrase == 'move' then
		if love.keyboard.isDown('w') or
		   love.keyboard.isDown('a') or
		   love.keyboard.isDown('s') or
		   love.keyboard.isDown('d') or
		   love.keyboard.isDown('up') or
		   love.keyboard.isDown('down') or
		   love.keyboard.isDown('right') or
		   love.keyboard.isDown('left') then
			self.phrase = 'space'
		end
	elseif self.phrase == 'space' then
		if self.player.holdingItem then
			self.phrase = 'ignite'
		end
	end

	if self.phrase == 'you' or self.phrase == 'time_left' or self.phrase == 'natives' then
	else
		self.player.update = self.playerUpdate
	end

	if self.phrase == 'ignite' then
		if self.colonizedBarbariansNum >= self.level.target then
			self.phrase = 'dancing'
		end
	end
	Scene_Tutorial._base.update(self, dt)
end

function Scene_Tutorial:draw()
	love.graphics.draw(R.images.bg, 0, 0)

	Scene_Tutorial._base.draw(self)

	if self.phrase == 'you' then
		love.graphics.draw(R.images.tutorial.you, 352, 226)
	elseif self.phrase == 'time_left' then
		love.graphics.draw(R.images.tutorial.timeLeft, 38, 520)
	elseif self.phrase == 'natives' then
		love.graphics.draw(R.images.tutorial.natives, 560, 500)
	elseif self.phrase == 'move' then
		love.graphics.draw(R.images.tutorial.move, 350, 174)
	elseif self.phrase == 'space' then
		love.graphics.draw(R.images.tutorial.space, 93, 168)
	elseif self.phrase == 'ignite' then
		love.graphics.draw(R.images.tutorial.ignite, 494, 218)
	elseif self.phrase == 'dancing' then
		love.graphics.draw(R.images.tutorial.dancing, 560, 500)
	end
end

function Scene_Tutorial:reachedTarget()
	return self.colonizedBarbariansNum >= self.target
end

function Scene_Tutorial:onKeyPressed()
	if self.phrase == 'dancing' then
		local canvas = love.graphics.newCanvas()
		canvas:renderTo(function()
			self:draw()
		end)
		Game.SceneManager:switchScene(Scene_Result,
			canvas, { status = 'win', next = 2 }
		)
	end
end

function Scene_Tutorial:onKeyReleased(key)
	if self.phrase == 'you' then
		self.phrase = 'time_left'
	elseif self.phrase == 'time_left' then
		self.phrase = 'natives'
	elseif self.phrase == 'natives' then
		self.phrase = 'move'
	elseif self.phrase == 'space' or self.phrase == 'ignite' then
		self._screen:onKeyReleased(key)
	end
end

return Scene_Tutorial
