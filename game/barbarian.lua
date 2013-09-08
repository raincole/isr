require 'vendor/class'

local Barbarian = class(Animator)

function Barbarian:__init(name)
    Barbarian._base.__init(self, name, R.anims.barbarian())
    self.ox = 16
    self.oy = 35
    self.width = 32
    self.height = 20
    self.speed = 60
    self.dir = Direction.CENTER
    self.tracing = false
    self.dancing = false
    self.hasTarget = false
    self.detectingRadius = 60
    self.reachedRadius = 50
    self.nextWayPoint = nil
    self.zIndex = 10
    self.anims.img = R.images.barbarian[math.random(3)]
    self.tutorial = false
end

function Barbarian:registerObservers()
    beholder.observe(Event.LIGHT_SOURCE, function(x, y, radius)
        if self:inRange(x, y, radius) then
            if ((not self.tracing) or self:reachedWayPoint()) then
                local escapeDistance = (radius + self.detectingRadius) / 1.5
                local rx = math.random(-escapeDistance, escapeDistance)
                local ry = math.sqrt(escapeDistance*escapeDistance-rx*rx)
                if math.random(2) == 1 then ry = -ry end
                self.nextWayPoint = Vect2(x + rx,
                                          y + ry)
            end
            self.hasTarget = true
        end
    end)
    beholder.observe(Event.CAMPFIRE, function(x, y, radius, callback)
        if (not self.dancing) and self:inRange(x, y, radius) then
            callback(self)
        end
    end)
end

function Barbarian:inRange(x, y, radius)
    local maxDistance = radius + self.detectingRadius
    local sqrMaxDistance = maxDistance * maxDistance
    local sqrDistance = (self.x - x) * (self.x - x) + (self.y - y) * (self.y - y)
    return sqrDistance <= sqrMaxDistance
end

function Barbarian:update(dt)
    Barbarian._base.update(self, dt)

    local __tracing = self.tracing
    self.tracing = self.hasTarget
    if __tracing == false and self.tracing == true and 
        (not self.dancing) and (not self.tutorial) then
        local emo = Emotion('Emotion', self.x - 2, self.y - self.oy, R.metadatas.emotion.notice)
        self:addEntity(emo)
    end

    if self.dancing then

    else
        if (not self.hasTarget) and (self:reachedWayPoint()) then
            self:randomWayPoint()
        end

        if self.nextWayPoint then
            if not self:moveToPoint(self.nextWayPoint, self.speed * dt) then
                self:randomWayPoint()
            end
        end
    end

    self.hasTarget = false
end

function Barbarian:randomWayPoint()
    self.nextWayPoint = { x = self.x + math.random(-200, 200),
                          y = self.y + math.random(-200, 200) }
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
    local realDisplacement = self:moveBy(displacement)

    return realDisplacement:magnitude() >= 0.5
end

function Barbarian:moveBy(displacement)
    local realDisplacement = self:tryToMove(displacement:normalized(), displacement:magnitude())
    self.dir = Direction.from4ApproxVect(realDisplacement)
    return realDisplacement
end

function Barbarian:reachedWayPoint()
    local point = self.nextWayPoint
    if not point then return true end

    local delta = Vect2(point.x - self.x, point.y - self.y)
    return delta:sqrMagnitude() < self.reachedRadius * self.reachedRadius
end

function Barbarian:getCurrentAnimIndex()
    if self.dancing then return 'dancing'
    else return self.dir end
end

function Barbarian:findCampfire()
    if not self.dancing then
        love.audio.play(R.sounds.dancing)
    end
    beholder.trigger(Event.CHANGE_COLONIZED_BARBARIANS, 1)
    self.dancing = true
end

function Barbarian:loseCampfire()
    beholder.trigger(Event.CHANGE_COLONIZED_BARBARIANS, -1)
    self.dancing = false
end

return Barbarian
