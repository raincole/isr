local newImage = love.graphics.newImage
local newSound = function (filename) return love.audio.newSource(filename, "static") end
local newMusic = function (filename) return love.audio.newSource(filename, "stream") end
local newQuad  = love.graphics.newQuad

local R = {}

R.images = {
	bg = newImage("assets/images/bg.png"),
	player = newImage("assets/images/sprites/player.png"),
	playerStick = newImage("assets/images/sprites/player_stick.png"),
	barbarian = newImage("assets/images/sprites/bab_1.png"),
    campfire =  newImage("assets/images/sprites/campfire.png"),
	sticks = {
		newImage("assets/images/sprites/stick_1.png"),
		newImage("assets/images/sprites/stick_2.png"),
		newImage("assets/images/sprites/stick_3.png"),
		newImage("assets/images/sprites/stick_4.png"),
		newImage("assets/images/sprites/stick_5.png"),
		newImage("assets/images/sprites/stick_6.png"),
	},
	stickfire = newImage("assets/images/sprites/stickfire.png"),
	thounder = newImage("assets/images/sprites/thounder.png"),
	countdown = {
		scene = {
			newImage("assets/images/ui/time_full.png"),
			newImage("assets/images/ui/time_empty.png"),
			newImage("assets/images/ui/time_bar.png"),
		},
		stick = newImage("assets/images/ui/stick_fire_life.png"),
		campfire = newImage("assets/images/ui/firecamp_life.png"),
	},
	conquerPoint = {
		newImage("assets/images/ui/people_icon.png"),
		newImage("assets/images/ui/people_0.png"),
		newImage("assets/images/ui/people_1.png"),
	},

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
			dancing   = newAnimation(R.images.barbarian, 34, 48, 0.2, {17, 18, 19, 20, 21, 22, 23, 24}),
		}
	end,
	stickfire = function()
		return { newAnimation(R.images.stickfire, 12, 26, 0.16, 0) }
	end,
	thounder = function()
		return { newAnimation(R.images.thounder, 32, 600, 0.08, 0) }
	end,
	campfire = function()
		return {
			normal = newAnimation(R.images.campfire, 52, 56, 0.16, {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}),
			glow = newAnimation(R.images.campfire, 52, 56, 0.16, {11, 12, 13, 14, 15,
					   										     16, 17, 18, 19, 20}),
		}
	end,
}

R.fonts = {
}

R.levels = {
	require 'assets/levels/1',
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
			width = R.images.sticks[1]:getWidth() / 2,
			height = R.images.sticks[1]:getHeight()
		},
		quad = {
			normal = newQuad(0, 0,
				R.images.sticks[1]:getWidth() / 2, R.images.sticks[1]:getHeight(),
				R.images.sticks[1]:getWidth(), R.images.sticks[1]:getHeight()
			),
			glow = newQuad(R.images.sticks[1]:getWidth() / 2, 0,
				R.images.sticks[1]:getWidth() / 2, R.images.sticks[1]:getHeight(),
				R.images.sticks[1]:getWidth(), R.images.sticks[1]:getHeight()
			),
		},
	},
	player = {
		speed = 150,
		firePosition = {
			{ x = 68, y = 24 }, { x = 70, y = 24 }, { x = 68, y = 24 }, { x = 66, y = 24 },
			{ x = 8 , y = 24 }, { x = 6 , y = 24 }, { x = 8 , y = 24 }, { x = 10, y = 24 },
			{ x = 60, y = 24 }, { x = 61, y = 26 }, { x = 60, y = 24 }, { x = 62, y = 22 },
			{ x = 15, y = 24 }, { x = 15, y = 22 }, { x = 15, y = 24 }, { x = 16, y = 25 },
		},
	},
	campfire = {
		oneStickLifespan = 7,
		upgradeThreshold = 5,
	},
	fire = {
		burnRadius = 25,
	},
	sceneCountdwon = {
		whole = {
			size = {
				width = R.images.countdown.scene[1]:getWidth(),
				height = R.images.countdown.scene[1]:getHeight()
			},
			quad = newQuad(0,0,189,28,189,28),
		},
		bar = {
			size = {
				width = R.images.countdown.scene[3]:getWidth(),
				height = R.images.countdown.scene[3]:getHeight()
			},
		},
	},
}

return R
