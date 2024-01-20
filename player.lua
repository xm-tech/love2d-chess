local player = {
	id = nil,
	name = nil,
	cap = -1,
	chesss = {}
}

function player:new(p)
	p  = p or {}
	setmetatable(p, self)
	self.__index = self
	return p
end
