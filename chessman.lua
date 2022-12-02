-- 棋子
local chess = {}

local chess_mt = {
	-- c: 主表
	init = function (c, id, x, y, cap, img, alive, name)
		c.id = id
		c.x = x
		c.y = y
		c.cap = cap
		c.img = img
		c.alive = alive
		c.name = name
	end,
	detail = function (c)
		print(c.idx, c.id, c.x, c.y, c.cap, c.img,c.alive, c.name)
	end
}

chess_mt['__index'] = chess_mt

function chess.new()
	local c = {
		-- 棋子唯一标识
		idx = nil,
		-- 棋子类别
		id = 0,
		-- x 坐标
		x = 0,
		-- y 坐标
		y = 0,
		-- 阵营
		cap = 0,
		-- 棋子图片名, etc: 0-0.png
		img = nil,
		-- 是否活着
		alive = true,
		-- 棋子名称
		name = "",
		-- 棋子 love2d 图片
		image = nil,
	}
	setmetatable(c, chess_mt)
	return c
end

return chess

-- local c0 = chess:new()
-- c0:init(0, 0, 0, 0, "img-c0", true)
-- local c1 = chess:new()
-- c1:init(1, 1, 1, 0, "img-c1", true)
-- c0:detail()
-- c1:detail()
