local newImage = love.graphics.newImage
local newSound = function (filename) return love.audio.newSource(filename, "static") end
local newMusic = function (filename) return love.audio.newSource(filename, "stream") end

local R = {}

R.images = {
	stone = newImage("assets/images/stone.png"),
	characterSheet = newImage("assets/images/sprites/characters.png"),
    --campfire =  newImage("assets/images/campfire.png"),
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
	player = function()
		return {
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
	end,
	barbarian = function()
		return {
			down = newAnimation(R.images.characterSheet, 32, 32, 0.2, {5, 6, 4}),
			left = newAnimation(R.images.characterSheet, 32, 32, 0.2, {17, 18, 16}),
			right = newAnimation(R.images.characterSheet, 32, 32, 0.2, {29, 30, 28}),
			up = newAnimation(R.images.characterSheet, 32, 32, 0.2, {41, 42, 40}),
			upRight = newAnimation(R.images.characterSheet, 32, 32, 0.2, {41, 42, 40}),
			upLeft = newAnimation(R.images.characterSheet, 32, 32, 0.2, {41, 42, 40}),
			downRight = newAnimation(R.images.characterSheet, 32, 32, 0.2, {41, 42, 40}),
			downLeft = newAnimation(R.images.characterSheet, 32, 32, 0.2, {41, 42, 40}),
			center = newAnimation(R.images.characterSheet, 32, 32, 0.2, {41, 42, 40}),
		}
	end,
}

R.fonts = {
}

return R
