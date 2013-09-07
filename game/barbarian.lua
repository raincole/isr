require 'vendor/class'

local Barbarian = class(Animator)

function Barbarian:__init(name)
    Barbarian._base.__init(self, name, R.anims.barbarian())
    self.ox = 16
    self.oy = 35
    self.width = 32
    self.height = 32
    self.speed = 60
    self.dir = Direction.CENTER
    self.turnInterval = 3
    self.turnTimer = 0
    self.zIndex = 10
end

function Barbarian:update(dt)
    Barbarian._base.update(self, dt)
    self.turnTimer = self.turnTimer - dt
    if self.turnTimer <= 0 then
        local dir = Direction.randomFrom8Dirs()
        self.dir = dir
        self.turnTimer = self.turnInterval
    end
    self:moveByDir(self.dir, self.speed * dt)
end

function Barbarian:moveByDir(dir, disp)
    local x = Direction.toVect(dir).x
    local y = Direction.toVect(dir).y
    local xDisp = math.sqrt(disp * (x * x) / (x * x + y * y)) * Mathx.sign(x)
    local yDisp = math.sqrt(disp * (y * y) / (x * x + y * y)) * Mathx.sign(y)
    self.x = self.x + xDisp
    self.y = self.y + yDisp
    self.dir = dir
end

function Barbarian:getCurrentAnimIndex()
    return self.dir
end

return Barbarian
