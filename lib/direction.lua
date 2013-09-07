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
	if dir == Direction.UP then return {x=0, y=-1} end
	if dir == Direction.RIGHT then return {x=1, y=0} end
	if dir == Direction.DOWN then return {x=0, y=1} end
	if dir == Direction.LEFT then return {x=-1, y=0} end
	if dir == Direction.UP_RIGHT then return {x=1, y=-1} end
	if dir == Direction.DOWN_RIGHT then return {x=1, y=1} end
	if dir == Direction.DOWN_LEFT then return {x=-1, y=1} end
	if dir == Direction.UP_LEFT then return {x=-1, y=-1} end
	if dir == Direction.CENTER then return {x=0, y=0} end
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

function Direction.comebine(dir1, dir2)
	local vect1 = Direction.toVect(dir1)
	local vect2 = Direction.toVect(dir2)
	local vect = { x = vect1.x + vect2.x, y = vect1.y + vect2.y }
	return Direction.fromVect(vect)
end

return Direction
