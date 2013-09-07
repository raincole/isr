local newImage = love.graphics.newImage
local newSound = function (filename) return love.audio.newSource(filename, "static") end
local newMusic = function (filename) return love.audio.newSource(filename, "stream") end
local newQuad  = love.graphics.newQuad

local R = {}

R.images = {
	bg = newImage("assets/images/bg.png"),
	stone = newImage("assets/images/stone.png"),
	player = newImage("assets/images/player.png"),
	playerStick = newImage("assets/images/player_stick.png"),
	barbarian = newImage("assets/images/bab_1.png"),
	characterSheet = newImage("assets/images/sprites/characters.png"),
    campfire =  newImage("assets/images/campfire.png"),
	sticks = {
		newImage("assets/images/sticks/stick_1.png"),
		newImage("assets/images/sticks/stick_2.png"),
		newImage("assets/images/sticks/stick_3.png"),
		newImage("assets/images/sticks/stick_4.png"),
		newImage("assets/images/sticks/stick_5.png"),
		newImage("assets/images/sticks/stick_6.png"),
	},
	stickfire = newImage("assets/images/stickfire.png"),
	thounder = newImage("assets/animation/thounder.png")
}

R.sounds = {
}

R.musics = {
}

R.anims = {
	player = function()
		return {
			left      = newAnimation(R.images.player, 34, 48, 0.1, {5, 6, 7, 8}),
			upLeft    = newAnimation(R.images.player, 34, 48, 0.1, {5, 6, 7, 8}),
			downLeft  = newAnimation(R.images.player, 34, 48, 0.1, {5, 6, 7, 8}),
			right     = newAnimation(R.images.player, 34, 48, 0.1, {1, 2, 3, 4}),
			upRight   = newAnimation(R.images.player, 34, 48, 0.1, {1, 2, 3, 4}),
			downRight = newAnimation(R.images.player, 34, 48, 0.1, {1, 2, 3, 4}),
			up        = newAnimation(R.images.player, 34, 48, 0.1, {13, 14, 15, 16}),
			down      = newAnimation(R.images.player, 34, 48, 0.1, {9, 10, 11, 12}),
			center    = newAnimation(R.images.player, 34, 48, 0.1, {9, 10, 11, 12}),
		}
	end,
	playerStick = function()
		return {
			left      = newAnimation(R.images.playerStick, 74, 48, 0.1, {5, 6, 7, 8}),
			upLeft    = newAnimation(R.images.playerStick, 74, 48, 0.1, {5, 6, 7, 8}),
			downLeft  = newAnimation(R.images.playerStick, 74, 48, 0.1, {5, 6, 7, 8}),
			right     = newAnimation(R.images.playerStick, 74, 48, 0.1, {1, 2, 3, 4}),
			upRight   = newAnimation(R.images.playerStick, 74, 48, 0.1, {1, 2, 3, 4}),
			downRight = newAnimation(R.images.playerStick, 74, 48, 0.1, {1, 2, 3, 4}),
			up        = newAnimation(R.images.playerStick, 74, 48, 0.1, {13, 14, 15, 16}),
			down      = newAnimation(R.images.playerStick, 74, 48, 0.1, {9, 10, 11, 12}),
			center    = newAnimation(R.images.playerStick, 74, 48, 0.1, {9, 10, 11, 12}),
		}
	end,
	barbarian = function()
		return {
			left      = newAnimation(R.images.barbarian, 34, 48, 0.1, {5, 6, 7, 8}),
			upLeft    = newAnimation(R.images.barbarian, 34, 48, 0.1, {5, 6, 7, 8}),
			downLeft  = newAnimation(R.images.barbarian, 34, 48, 0.1, {5, 6, 7, 8}),
			right     = newAnimation(R.images.barbarian, 34, 48, 0.1, {1, 2, 3, 4}),
			upRight   = newAnimation(R.images.barbarian, 34, 48, 0.1, {1, 2, 3, 4}),
			downRight = newAnimation(R.images.barbarian, 34, 48, 0.1, {1, 2, 3, 4}),
			up        = newAnimation(R.images.barbarian, 34, 48, 0.1, {13, 14, 15, 16}),
			down      = newAnimation(R.images.barbarian, 34, 48, 0.1, {9, 10, 11, 12}),
			center    = newAnimation(R.images.barbarian, 34, 48, 0.1, {9, 10, 11, 12}),
		}
	end,
	stickfire = function()
		return { newAnimation(R.images.stickfire, 12, 26, 0.16, 0) }
	end,
	thounder = function()
		return { newAnimation(R.images.thounder, 32, 600, 0.08, 0) }
	end,
	campfire = function()
		return { newAnimation(R.images.campfire, 50, 56, 0.16, 0) }
	end,
}

R.fonts = {
}

R.metadatas = {
	stick = {
		firePosition = {
			{ x = 27, y = 3  },
			{ x = 29, y = 3  },
			{ x = 6 , y = 13 },
			{ x = 28, y = 7  },
			{ x = 6 , y = 3  },
			{ x = 8 , y = 4  },
		},
		size = {
			width = R.images.sticks[1]:getWidth(),
			height = R.images.sticks[1]:getHeight()
		},
		quad = {
			normal = newQuad(0, 0, 
				R.images.sticks[1]:getWidth() / 2, R.images.sticks[1]:getHeight(),
				R.images.sticks[1]:getWidth(), R.images.sticks[1]:getHeight()
			),
			fired = newQuad(R.images.sticks[1]:getWidth() / 2, 0, 
				R.images.sticks[1]:getWidth() / 2, R.images.sticks[1]:getHeight(),
				R.images.sticks[1]:getWidth(), R.images.sticks[1]:getHeight()
			),
		},
	},
	player = {
		firePosition = {
			{ x = 68, y = 24 }, { x = 70, y = 24 }, { x = 68, y = 24 }, { x = 66, y = 24 },
			{ x = 8 , y = 24 }, { x = 6 , y = 24 }, { x = 8 , y = 24 }, { x = 10, y = 24 },
			{ x = 60, y = 24 }, { x = 61, y = 26 }, { x = 60, y = 24 }, { x = 62, y = 22 },
			{ x = 15, y = 24 }, { x = 15, y = 22 }, { x = 15, y = 24 }, { x = 16, y = 25 },
		},
	},
	campfire = {
		oneStickLifespan = 2,
		upgradeThreshold = 5,
	},
	fire = {
		burnRadius = 30,
	},
}

return R
