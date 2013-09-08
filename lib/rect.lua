require 'vendor/class'

local Rect = class()

function Rect:__init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
end

function Rect:contains(x, y)
	return x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height
end

function Rect:collisionTime(other, velocity)
	local xNear, xFar, yNear, yFar
	local xEnter, xExit, yEnter, yExit

	if velocity.x > 0 then
		xNear = other.x - (self.x + self.width)
		xFar  = (other.x + other.width) - self.x
	else
		xFar  = other.x - (self.x + self.width)
		xNear = (other.x + other.width) - self.x
	end
	if velocity.y > 0 then
		yNear = other.y - (self.y + self.height)
		yFar  = (other.y + other.height) - self.y
	else
		yFar  = other.y - (self.y + self.height)
		yNear = (other.y + other.height) - self.y
	end

	if math.abs(velocity.x) < 1e-9 then
		if Mathx.sign(xNear) * Mathx.sign(xFar) == -1 then
			xEnter = -math.huge
		else
			xEnter = math.huge
		end
		xExit = -xEnter
	else
		xEnter = xNear / velocity.x
		xExit = xFar / velocity.x
	end
	if math.abs(velocity.y) < 1e-9 then
		if Mathx.sign(yNear) * Mathx.sign(yFar) == -1 then
			yEnter = -math.huge
		else
			yEnter = math.huge
		end
		yExit = -yEnter
	else
		yEnter = yNear / velocity.y
		yExit = yFar / velocity.y
	end

	local enter = math.max(xEnter, yEnter)
	local exit = math.min(xExit, yExit)

	if exit < 1e-5 then
		return math.huge
	elseif enter < 0 and exit > 0 then
		return math.huge
	else
		return enter
	end
end

function Rect:__tostring()
	return '{Rect => x: ' .. self.x .. ', y: ' .. self.y ..
		   ', width: ' .. self.width .. ', height: ' .. self.height .. '}'
end

return Rect
