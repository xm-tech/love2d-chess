-- 棋子
local chess = {
	-- 棋子唯一标识
	id = nil,
	-- 棋子类别表识
	tid = nil,
	-- x 坐标
	x = 0,
	-- y 坐标
	y = 0,
	-- 阵营
	cap = 0,
	-- 棋子颜色
	color = 1,
	-- 棋子图片名, etc: 0-0.png
	img = nil,
	-- 是否活着
	alive = true,
	-- 棋子名称
	name = "",
	-- 棋子 love2d 图片
	image = nil,
	-- 是否被选中
	selected = false,
}

function chess:new(c)
	c = c or {}
	setmetatable(c, self)
	self.__index = self
	return c
end

function chess:init(id, tid, x, y, cap, img, alive, name)
	self.id = id
	self.tid = tid
	self.x = x
	self.y = y
	self.cap = cap
	self.img = img
	self.alive = alive
	self.name = name
	self.selected = false
end

function chess:move(nx, ny)
	print("chess move,x:", x, ",y:", y, ",nx:", nx, ",ny:", ny)
	self.x = nx
	self.y = ny
end

function chess:select()
	self.selected = true
	-- print("select, cid:", self.id)
end

function chess:unselect()
	self.selected = false
end

function chess:die()
	self.alive = false
end

function chess:detail()
	print(self.id, self.tid, self.x, self.y, self.cap, self.img,self.alive, self.name)
end

return chess
