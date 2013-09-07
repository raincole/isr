require 'vendor/class'

local StickManager = class(Entity)

function StickManager:__init(name)
	self._base.__init(self, name)
	self.blockSize = {x = 4, y = 3}
	self._sticksID = {}
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

function StickManager:addStick(stick, info)
	if info == nil then -- real position
		info = { x = math.floor(stick.x / (love.graphics.getWidth() / self.blockSize.x) + 1),
				  y = math.floor(stick.y / (love.graphics.getHeight() / self.blockSize.y) + 1) }
	end
	self._blocks[info.x][info.y] = self._blocks[info.x][info.y] + 1
	self._sticksCount = self._sticksCount + 1
	if self._blocks[info.x][info.y] > self._blockMaxCount then
		self._blockMaxCount = self._blocks[info.x][info.y]
	end
	table.insert(self._sticksID, stick)
	info.ID = #self._sticksID
	self._sticks[stick] = info
	self:addEntity(stick)
end

function StickManager:removeStick(stick)
	local info = self._sticks[stick]
	self._blocks[info.x][info.y] = self._blocks[info.x][info.y] - 1
	self._sticksID[info.ID] = nil
	self._sticks[stick] = nil
	stick:removeSelf()
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

--- TODO: anime
function StickManager:randomLightStick()
	--local rand = math.random(self._sticksCount)
	--self._sticks[rand].fired = true
end

return StickManager
