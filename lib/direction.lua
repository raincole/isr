local Direction = {
	UP = 'up',
	RIGHT = 'right',
	DOWN = 'down',
	LEFT = 'left',
	UP_RIGHT = 'upRight',
	DOWN_RIGHT = 'downRight',
	DOWN_LEFT = 'downLeft',
	UP_LEFT = 'upLeft',
	CENTER = 'center',
}

function Direction.fromKey(keyname)
	keyname = string.lower(keyname)
	if keyname == 'up' or keyname == 'w' then return Direction.UP end
	if keyname == 'right' or keyname == 'd' then return Direction.RIGHT end
	if keyname == 'down' or keyname == 's' then return Direction.DOWN end
	if keyname == 'left' or keyname == 'a' then return Direction.LEFT end
end

function Direction.toVect(dir)
	if dir == Direction.UP then return Vect2(0, -1) end
	if dir == Direction.RIGHT then return Vect2(1, 0) end
	if dir == Direction.DOWN then return Vect2(0, 1) end
	if dir == Direction.LEFT then return Vect2(-1, 0) end
	if dir == Direction.UP_RIGHT then return Vect2(1, -1) end
	if dir == Direction.DOWN_RIGHT then return Vect2(1, 1) end
	if dir == Direction.DOWN_LEFT then return Vect2(-1, 1) end
	if dir == Direction.UP_LEFT then return Vect2(-1, -1) end
	if dir == Direction.CENTER then return Vect2(0, 0) end
end

function Direction.fromVect(vect)
	if vect.x == 0 and vect.y == -1 then return Direction.UP end
	if vect.x == 1 and vect.y == 0 then return Direction.RIGHT end
	if vect.x == 0 and vect.y == 1 then return Direction.DOWN end
	if vect.x == -1 and vect.y == 0 then return Direction.LEFT end
	if vect.x == 1 and vect.y == -1 then return Direction.UP_RIGHT end
	if vect.x == 1 and vect.y == 1 then return Direction.DOWN_RIGHT end
	if vect.x == -1 and vect.y == 1 then return Direction.DOWN_LEFT end
	if vect.x == -1 and vect.y == -1 then return Direction.UP_LEFT end
	if vect.x == 0 and vect.y == 0 then return Direction.CENTER end
end

function Direction.from4ApproxVect(vect)
	local maxDot = -math.huge
	local best = nil
	for i, d in ipairs(Direction.all4Dirs()) do
		local dot = vect:dot(Direction.toVect(d):normalized())
		if dot > maxDot then
			maxDot = dot
			best = d
		end
	end
	return best
end

function Direction.comebine(dir1, dir2)
	local vect1 = Direction.toVect(dir1)
	local vect2 = Direction.toVect(dir2)
	local vect = { x = vect1.x + vect2.x, y = vect1.y + vect2.y }
	return Direction.fromVect(vect)
end

function Direction.all4Dirs()
	return {
		Direction.UP,
		Direction.RIGHT,
		Direction.DOWN,
		Direction.LEFT,
	}
end

function Direction.all8Dirs()
	return {
		Direction.UP,
		Direction.RIGHT,
		Direction.DOWN,
		Direction.LEFT,
		Direction.UP_RIGHT,
		Direction.DOWN_RIGHT,
		Direction.DOWN_LEFT,
		Direction.UP_LEFT,
	}
end

function Direction.randomFrom8Dirs()
	return Direction.all8Dirs()[math.random(8)]
end

return Direction
