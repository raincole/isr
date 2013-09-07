local newImage = love.graphics.newImage
local newSound = function (filename) return love.audio.newSource(filename, "static") end
local newMusic = function (filename) return love.audio.newSource(filename, "stream") end

local R = {}

R.images = {
	bg = newImage("assets/images/bg.png"),
	stone = newImage("assets/images/stone.png"),
	player = newImage("assets/images/player.png"),
	barbarian = newImage("assets/images/bab_1.png"),
	characterSheet = newImage("assets/images/sprites/characters.png"),
    --campfire =  newImage("assets/images/campfire.png"),
	sticks = {
		newImage("assets/images/sticks/stick_1.png"),
		newImage("assets/images/sticks/stick_2.png"),
		newImage("assets/images/sticks/stick_3.png"),
		newImage("assets/images/sticks/stick_4.png"),
		newImage("assets/images/sticks/stick_5.png"),
		newImage("assets/images/sticks/stick_6.png"),
	},
	stickfire = newImage("assets/images/stickfire.png"),
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
}

R.fonts = {
}

R.metadatas = {
	stick = {
		firePosition = {
			{ x = 24, y = 4  },
			{ x = 22, y = 6  },
			{ x = 8 , y = 10 },
			{ x = 24, y = 14 },
			{ x = 2 , y = 4  },
			{ x = 23, y = 6  },
		}
	}
}

return R
