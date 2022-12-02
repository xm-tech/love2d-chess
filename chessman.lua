-- 棋子
local chess = {}


local chess_mt = {
	init = function (c, id, x, y, cap, img, alive)
		c.id = id
		c.x = x
		c.y = y
		c.cap = cap
		c.img = img
		c.alive = alive
	end
}

chess_mt['__index'] = chess_mt

function chess.new()
	local c = {
		-- 棋子ID
		id = 0,
		-- x 坐标
		x = 0,
		-- y 坐标
		y = 0,
		-- 阵营
		cap = 0,
		-- 棋子图片
		img = nil,
		-- 是否活着
		alive = true,
	}
	setmetatable(c, chess_mt)
	return c
end

return chess
-- local c0 = chess:new()
-- c0:init(0, 0, 0, 0, "img-c0", true)
-- local c1 = chess:new()
-- c1:init(1, 1, 1, 0, "img-c1", true)
-- print(c1.id, c1.x, c1.y, c1.cap, c1.img, c1.alive)
-- print(c0.id, c0.x, c0.y, c0.cap, c0.img, c0.alive)
