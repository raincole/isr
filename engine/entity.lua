require 'vendor/class'

local Entity = class()

function Entity:__init(name)
	self._name = name
	self.children = {}
	self.parent = nil
	self._observerId = {}
	self.toRemove = false
	self.zIndex = 0
end

function Entity:registerObservers() end

function Entity:draw()
	table.sort(self.children, function(a, b)
		return a.zIndex < b.zIndex
	end)
	for i, e in ipairs(self.children) do
		e:draw()
	end
end

function Entity:update(dt)
	for i, e in ipairs(self.children) do
		e:update(dt)
	end
end

function Entity:afterUpdate()
	local toRemoves = _.select(self.children, function(e) return e.toRemove end)
	self.children = _.reject(self.children, function(e) return e.toRemove end)

	for i, e in ipairs(toRemoves) do
		e:onRemoved()
	end

	for i, e in ipairs(self.children) do
		e:afterUpdate(dt)
	end
end

function Entity:onAdded(parent)
	beholder.group(self._observerId, function() self:registerObservers() end)
	self.parent = parent
	self.toRemove = false
end

function Entity:onRemoved()
	self.parent = nil
	beholder.stopObserving(self._observerId)

	for i, e in ipairs(self.children) do
		e:onRemoved()
	end
end

function Entity:addEntity(entity)
	table.insert(self.children, entity)
	entity:onAdded(self)
end

function Entity:addEntities(entities)
	for i, e in ipairs(entities) do
		self:addEntity(e)
	end
end

function Entity:removeSelf()
	self.toRemove = true
end

function Entity:onMousePressed(x, y, button)
	for i, e in ipairs(self.children) do
		if e:onMousePressed(x, y, button) then
			return true
		end
	end

	return false
end

function Entity:onMouseReleased(x, y, button)
	for i, e in ipairs(self.children) do
		if e:onMouseReleased(x, y, button) then
			return true
		end
	end

	return false
end

function Entity:onKeyReleased(key)
	for i, e in ipairs(self.children) do
		if e:onKeyReleased(key) then
			return true
		end
	end

	return false
end

return Entity
