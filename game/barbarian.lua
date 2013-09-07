require 'vendor/class'

local Barbarian = class(Animator)

function Barbarian:__init(name)
    Barbarian._base.__init(self, name, R.anims.barbarian())
    self.ox = 16
    self.oy = 35
    self.speed = 60
    self.dir = Direction.CENTER
    self.tracing = false
    self.detectingRadius = 60
    self.reachedRadius = 50
    self.nextWayPoint = nil
    self.zIndex = 10
end

function Barbarian:registerObservers()
    beholder.observe(Event.LIGHT_SOURCE, function(x, y, radius)
        local maxDistance = radius + self.detectingRadius
        local sqrMaxDistance = maxDistance * maxDistance
        local sqrDistance = (self.x - x) * (self.x - x) + (self.y - y) * (self.y - y)
        if sqrDistance <= sqrMaxDistance and self:reachedWayPoint() then
            local escapeDistance = maxDistance / 1.5
            local rx = math.random(-escapeDistance, escapeDistance)
            local ry = math.sqrt(escapeDistance*escapeDistance-rx*rx)
            if math.random(2) == 1 then ry = -ry end
            self.nextWayPoint = Vect2(x + rx,
                                      y + ry)
            self.tracing = true
        end
    end)
end

function Barbarian:update(dt)
    Barbarian._base.update(self, dt)

    if (not self.tracing) and (self:reachedWayPoint()) then
        self.nextWayPoint = { x = self.x + math.random(-200, 200),
                              y = self.y + math.random(-200, 200) }
    end

    if self.nextWayPoint then
        self:moveToPoint(self.nextWayPoint, self.speed * dt)
    end

    self.tracing = false
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
    if not point then return true end

    local delta = Vect2(point.x - self.x, point.y - self.y)
    return delta:sqrMagnitude() < self.reachedRadius * self.reachedRadius
end

function Barbarian:getCurrentAnimIndex()
    return self.dir
end

return Barbarian
