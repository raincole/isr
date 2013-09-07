require 'vendor/class'

local Barbarian = class(Animator)

function Barbarian:__init(name)
    Barbarian._base.__init(self, name, R.anims.barbarian())
    self.width = 32
    self.height = 32
    self.dir = Direction.CENTER
end

function Barbarian:update(dt)
    Barbarian._base.update(self, dt)
end

function Barbarian:draw()
    Barbarian._base.draw(self)
end

function Barbarian:getCurrentAnimIndex()
    return self.dir
end

return Barbarian
