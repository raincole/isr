require 'vendor/class'

local Vect2 = class()

function Vect2:__init(x, y)
	self.x = x
	self.y = y
end

function Vect2:add(other)
	return Vect2(self.x + other.x, self.y + other.y)
end

function Vect2:sqrMagnitude()
	return self.x * self.x + self.y * self.y
end

function Vect2:magnitude()
	return math.sqrt(self:sqrMagnitude())
end

function Vect2:normalized()
	local mag = self:magnitude()
	if math.abs(mag) < 1e-9 then return Vect2(0, 0)
	else return Vect2(self.x / mag, self.y / mag) end
end

function Vect2:scale(f)
	return Vect2(self.x * f, self.y * f)
end

function Vect2:stretchTo(length)
	return self:normalized():scale(length)
end

function Vect2:dot(other)
	return self.x * other.x + self.y * other.y
end

function Vect2:__tostring()
	return "{x = " .. self.x .. ", y = " .. self.y .. "}"
end

return Vect2
