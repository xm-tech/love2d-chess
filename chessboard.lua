local g = require "global"

-- 棋盘
local M = {
	chess_board = g.love.graphics.newImage("assets/ChessBoard.png"),
	x = 0,
	y = 0,
	-- 所有棋子
	chesses = {},
	-- 格子棋子映射
	grid_chess_map = {},
	-- 选中的棋子
	chess_selected = {},
	-- 目标位置
	target_pos = {},
}


-- 初始化棋子数据
local function init_chesses()
	math.randomseed(os.time())
	-- 方阵营(颜色), 0-红, 1-黑
	local me = math.random(2)
	-- 对方阵营
	local oppo
	if me == 1 then oppo = 2 else oppo = 1 end
	-- 棋子唯一标识
	local id = 0
	local chess = require "chessman"

	local function _init_chesses(who, _cap)
		for _, data in pairs(g.chess_both[who]) do
			-- data: {棋子类别，x, y, 名称}
			local c = chess:new()
			id = id + 1
			print("id:", id, "cap:", _cap, "type:", data[1], "x:", data[2], "y:", data[3], "name:", data[4])
			local img = (_cap-1).."-"..data[1]..".png"
			-- id, tid, x, y, cap, img, alive, name
			c:init(id, data[1], data[2], data[3], _cap, img, true, data[4])
			c.image = g.love.graphics.newImage("assets/"..c.img)
			M.chesses[c.id] = c
			local grid = g.get_grid_idx(c.x, c.y)
			M.grid_chess_map[grid + 1] = c
		end
	end

	-- 初始化己方棋子
	_init_chesses(1, me)
	-- 初始化对方棋子
	_init_chesses(2, oppo)
end

M.init = function ()
	print("on chessboard init")
	g.love.window.setMode(g.win_width, g.win_height)
	g.love.window.setTitle(g.title)

	init_chesses()
end

M.draw = function ()
	-- 画棋盘
	g.love.graphics.draw(M.chess_board, M.x, M.y)

	-- 画棋子
	for _, c in pairs(M.chesses) do
		if c.alive then
			g.love.graphics.draw(c.image, c.x, c.y)
		end
	end
end

M.mouse_pressed = function(x, y, button, istouch)
	local grid = g.get_grid_idx(x, y)
	local grid_chess = M.grid_chess_map[grid + 1]
	local grid_chess_name = nil
	if grid_chess then
		grid_chess_name = grid_chess.name
	else
		grid_chess_name = "no"
	end
	print("mousepressed, button:", button, "istouch:", istouch, "x:", x, "y:", y, "grid:", grid, "chess_name:", grid_chess_name, "cap:", grid_chess.cap)
end

return M
