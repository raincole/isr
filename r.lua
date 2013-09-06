local newImage = love.graphics.newImage
local newSound = function (filename) return love.audio.newSource(filename, "static") end
local newMusic = function (filename) return love.audio.newSource(filename, "stream") end

R = {
	images = {
	},
	sounds = {
	},
	musics = {
	},
}
