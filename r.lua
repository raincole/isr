local newImage = love.graphics.newImage
local newSound = function (filename) return love.audio.newSource(filename, "static") end
local newMusic = function (filename) return love.audio.newSource(filename, "stream") end

R = {}

R.images = {
	stone = newImage("assets/images/stone.png"),
	characterSheet = newImage("assets/images/sprites/characters.png"),
    --campfire =  newImage("assets/images/campfire.png"),
}

R.sounds = {
}

R.musics = {
}

R.anims = {
	player = {
		down = newAnimation(R.images.characterSheet, 32, 32, 0.2, {1, 2, 3}),
		left = newAnimation(R.images.characterSheet, 32, 32, 0.2, {13, 14, 15}),
		right = newAnimation(R.images.characterSheet, 32, 32, 0.2, {25, 26, 27}),
		up = newAnimation(R.images.characterSheet, 32, 32, 0.2, {37, 38, 39}),
	}
}

R.fonts = {
}
