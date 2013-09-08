require 'vendor/class'

local Scene_Game = class(Scene_Base)

function Scene_Game:__init(info, level)
	Scene_Game._base.__init(self, info)

	Game.player = Player('player')
	Game.player.x = 320
	Game.player.y = 240
	self._screen:addEntity(Game.player)

	self.stickManager = StickManager("stickManager")
	self._screen:addEntity(self.stickManager)
	for i = 1, 20 do
		self.stickManager:randomAddStick()
	end

	local countdown = Countdown(10)
	self._screen:addEntity(countdown)

	self.barbarianManager = BarbarianManager("barbarianManager")
	self._screen:addEntity(self.barbarianManager)
	for i = 1, 5 do
		self.barbarianManager:randomAddBarbarian()
	end

	self.colonizedBarbariansNum = 0
	beholder.observe(Event.CHANGE_COLONIZED_BARBARIANS, function(n)
		self.colonizedBarbariansNum = self.colonizedBarbariansNum + n
	end)

	self.index = level.index
	self.target = level.target

	local conquerPoint = ConquerPoint("conquerPoint", self)
	self._screen:addEntity(conquerPoint)	

	--rock test
	local element = Sand("ele",51,51)
	self._screen:addEntity(element)
end

function Scene_Game:update(dt)
	if math.random(1000) < 17 then self.barbarianManager:randomAddBarbarian() end
	if math.random(1000) < 17 then self.stickManager:randomLightStick() end
	if math.random(1000) < 37 then self.stickManager:randomAddStick() end

	Scene_Game._base.update(self, dt)
end

function Scene_Game:draw()
	love.graphics.draw(R.images.bg, 0, 0)

	Scene_Game._base.draw(self)
end

function Scene_Game:reachedTarget()
	return self.colonizedBarbariansNum >= self.target
end

return Scene_Game
