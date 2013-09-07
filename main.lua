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

	local stones = {}
	for i = 1, 100 do
		table.insert(stones, Actor('stone', R.images.stone,
								   math.random(1280), math.random(960)))
	end
	screen:addEntities(stones)

	local timer = Timer('timer', 3)
	screen:addEntity(timer)

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
	Game.currentScreen:update(dt)
	Game.currentScreen:afterUpdate()
end

function love.draw()
	Game.currentScreen:draw()
end
