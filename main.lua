require 'initialize'

Game = {
	currentScreen = nil,
	debug = true,
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

	Game.currentScreen = screen
end

function love.load()
	if Game.debug then
		math.randomseed(3336661)
	else
		math.randomseed(os.time)
	end

	require 'r'
	init()
end

function love.update(dt)
	if math.random(1000) < 17 then stickManager:randomAddStick() end
	Game.currentScreen:update(dt)
	Game.currentScreen:afterUpdate()
end

function love.draw()
	Game.currentScreen:draw()
end
