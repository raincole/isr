require 'initialize'

Game = {
	currentScreen = nil,
	debug = true,
	timerManager = TimerManager(),

}

function init()
	local screen = Screen()

	local player = Player('player')
	player.x = 320
	player.y = 240
	screen:addEntity(player)

	stickManager = StickManager("stickManager")
	screen:addEntity(stickManager)
	for i = 1, 20 do
		stickManager:randomAddStick()
	end

	local countdown = Countdown(10)
	screen:addEntity(countdown)

	barbarianManager = BarbarianManager("barbarianManager")
	screen:addEntity(barbarianManager)
	for i = 1, 5 do
		barbarianManager:randomAddBarbarian()
	end

	Game.currentScreen = screen
end

-- TODO: move into scene
function getStickManager()
	return stickManager
end

function love.load()
	if Game.debug then
		math.randomseed(3336661)
	else
		math.randomseed(os.time)
	end

	init()
end

function love.update(dt)
	if math.random(1000) < 17 then barbarianManager:randomAddBarbarian() end
	if math.random(1000) < 17 then stickManager:randomLightStick() end
	if math.random(1000) < 37 then stickManager:randomAddStick() end

	Game.timerManager:update(dt)

	Game.currentScreen:update(dt)
	Game.currentScreen:afterUpdate()
end

function love.draw()
	love.graphics.draw(R.images.bg, 0, 0)
	Game.currentScreen:draw()
end

function love.mousepressed(x, y, button)
	Game.currentScreen:onMousePressed(x, y, button)
end

function love.mousereleased(x, y, button)
	Game.currentScreen:onMouseReleased(x, y, button)
end

function love.keyreleased(key)
	Game.currentScreen:onKeyReleased(key)
end
