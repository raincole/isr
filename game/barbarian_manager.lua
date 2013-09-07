require 'vendor/class'

local BarbarianManager = class(Entity)

function BarbarianManager:__init(name)
	BarbarianManager._base.__init(self, name)
	self._barbarians = {}
end

function BarbarianManager:addBarbarian(barbarian)
	self.parent:addEntity(barbarian)
end

function BarbarianManager:randomAddBarbarian()
	local barbarian = Barbarian('barbarian')
	local dir = math.random(4)
	local minX = 0
	local maxX = 780
	local minY = 0
	local maxY = 580

	if dir == 1 then
		barbarian.x = math.random(maxX)
		barbarian.y = minY
	elseif dir == 2 then
		barbarian.x = maxX
		barbarian.y = math.random(maxY)
	elseif dir == 3 then
		barbarian.x = math.random(maxX)
		barbarian.y = maxY
	elseif dir == 4 then
		barbarian.x = minX
		barbarian.y = math.random(maxY)
	end
	table.insert(self._barbarians, barbarian)
	self:addBarbarian(barbarian)
end

return BarbarianManager
