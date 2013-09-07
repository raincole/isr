require 'vendor/class'

local StickManager = class(Entity)

function StickManager:__init(name)
	self._base.__init(self, name)
	self.blockSize = {x = 4, y = 3}
	self._sticks = {}
	self._blocks = {}
	for i = 1, self.blockSize.x do
		self._blocks[i] = {}
		for j = 1, self.blockSize.y do
			self._blocks[i][j] = 0
		end
	end
	self._sticksCount = 0
	self._blockMaxCount = 0
end

function StickManager:getRealPosition(block, position)
	return { x = (block.x - 1) * (love.graphics.getWidth() / self.blockSize.x) + position.x,
			 y = (block.y - 1) * (love.graphics.getHeight() / self.blockSize.y) + position.y }
end

function StickManager:addStick(stick, block)
	if block == nil then -- real position
		block = { x = stick.ox / self.blockSize.x, 
				  y = stick.oy / self.blockSize.y }
	end
	self._blocks[block.x][block.y] = self._blocks[block.x][block.y] + 1
	self._sticksCount = self._sticksCount + 1
	if self._blocks[block.x][block.y] > self._blockMaxCount then
		self._blockMaxCount = self._blocks[block.x][block.y]
	end
	self:addEntity(stick)
end

function StickManager:randomBlock()
	local rand = math.random((self._blockMaxCount + 1) * self.blockSize.x * self.blockSize.y - self._sticksCount)
	for i = 1, self.blockSize.x do
		for j = 1, self.blockSize.y do
			rand = rand - (self._blockMaxCount + 1 - self._blocks[i][j])
			if rand <= 0 then
				return {x = i, y = j}
			end
		end
	end

	return self.blockSize
end

function StickManager:randomPosition()
	return { x = math.random(love.graphics.getWidth() / self.blockSize.x),
			 y = math.random(love.graphics.getHeight() / self.blockSize.y) }
end

function StickManager:randomAddStick()
	local randBlock = self:randomBlock()
	local randPos = self:randomPosition()
	local stickDebugName = string.format("stick [%d, %d] (%d, %d)", randBlock.x, randBlock.y, randPos.x, randPos.y)
	local realPosition = self:getRealPosition(randBlock, randPos)
	stick = Stick(stickDebugName, realPosition.x, realPosition.y)
	self:addStick(stick, randBlock)
end

return StickManager
