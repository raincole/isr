require 'vendor/class'

local Barbarian = class(Animator)

function Barbarian:__init(name)
    Barbarian._base.__init(self, name, R.anims.barbarian())
    self.ox = 16
    self.oy = 35
    self.speed = 60
    self.dir = Direction.CENTER
    self.turnInterval = 3
    self.turnTimer = 0
    self.nextWayPoint = nil
    self.zIndex = 10
end

function Barbarian:update(dt)
    Barbarian._base.update(self, dt)
    self.turnTimer = self.turnTimer - dt
    if self.turnTimer <= 0 or self:reachedWayPoint() then
        self.nextWayPoint = { x = math.random(800), y = math.random(600) }
        self.turnTimer = self.turnInterval
    end
    self:moveToPoint(self.nextWayPoint, self.speed * dt)
end

function Barbarian:moveToPoint(point, frameSpeed)
    local delta = Vect2(point.x - self.x, point.y - self.y)
    local distance = delta:magnitude()
    local displacement = nil
    if distance < frameSpeed then
        displacement = delta
    else
        displacement = delta:normalized():scale(frameSpeed)
    end
    self:moveBy(displacement)
end

function Barbarian:moveBy(displacement)
    self.x = self.x + displacement.x
    self.y = self.y + displacement.y
    self.dir = Direction.fromApproxVect(displacement)
end

function Barbarian:reachedWayPoint()
    local point = self.nextWayPoint
    local delta = Vect2(point.x - self.x, point.y - self.y)
    return delta:sqrMagnitude() < 5
end

function Barbarian:getCurrentAnimIndex()
    return self.dir
end

return Barbarian
