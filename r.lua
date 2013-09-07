local newImage = love.graphics.newImage
local newSound = function (filename) return love.audio.newSource(filename, "static") end
local newMusic = function (filename) return love.audio.newSource(filename, "stream") end

local R = {}

R.images = {
	stone = newImage("assets/images/stone.png"),
	characterSheet = newImage("assets/images/sprites/characters.png"),
	sticks = {
		{
			normal = newImage("assets/images/stick.png"),
			fired  = newImage("assets/images/stick.png"),
		},
	},
}

R.sounds = {
}

R.musics = {
}

R.anims = {
	player = {
		down = newAnimation(R.images.characterSheet, 32, 32, 0.2, {2, 3, 1}),
		left = newAnimation(R.images.characterSheet, 32, 32, 0.2, {14, 15, 13}),
		right = newAnimation(R.images.characterSheet, 32, 32, 0.2, {26, 27, 25}),
		up = newAnimation(R.images.characterSheet, 32, 32, 0.2, {38, 39, 37}),
		upRight = newAnimation(R.images.characterSheet, 32, 32, 0.2, {38, 39, 37}),
		upLeft = newAnimation(R.images.characterSheet, 32, 32, 0.2, {38, 39, 37}),
		downRight = newAnimation(R.images.characterSheet, 32, 32, 0.2, {38, 39, 37}),
		downLeft = newAnimation(R.images.characterSheet, 32, 32, 0.2, {38, 39, 37}),
		center = newAnimation(R.images.characterSheet, 32, 32, 0.2, {38, 39, 37}),
	}
}

R.fonts = {
}

return R
