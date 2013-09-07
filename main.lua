require 'initialize'

Game = {
	currentScreen = nil,
	debug = true,
}

function init()
	local screen = Screen()

	local sticks = {}
	for i = 1, 100 do
		table.insert(sticks,
			Stick(string.format('stick #%d', i),
				  math.random(love.graphics.getWidth()), math.random(love.graphics.getHeight())))
	end
	screen:addEntities(sticks)

	local timer = Timer('timer', 3)
	screen:addEntity(timer)

	local player = Player('player')
	player.x = 320
	player.y = 240
	screen:addEntity(player)

	Game.currentScreen = screen
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
	Game.currentScreen:update(dt)
	Game.currentScreen:afterUpdate()
end

function love.draw()
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
