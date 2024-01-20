local g = require "global"

-- 棋盘
local M = {
	chess_board = g.love.graphics.newImage("assets/ChessBoard.png"),
	x = 0,
	y = 0,
	-- 棋局玩家
	players = {},
	-- 所有棋子
	chesses = {},
	-- 格子棋子映射
	grid_chess_map = {},
	-- 选中的棋子
	chess_selected = {},
	-- 目标位置
	target_pos = {},
	-- 我方阵营
	our_cap = nil,
	-- 对方阵营
	other_cap = nil,
}


-- 初始化棋子数据
local function init_chesses(cap)
	local chess = require "chess"
	for _, chesscnf in pairs(g.chess_both[cap]) do
		-- chesscnf: {棋子类别，x, y, 名称}
		local c = chess:new()
		-- id = id + 1
		id = chesscnf[1]
		tid = chesscnf[2]
		x = chesscnf[3]
		y = chesscnf[4]
		name = chesscnf[5]
		local img = (cap-1).."-"..tid..".png"
		-- id, tid, x, y, cap, img, alive, name
		c:init(id, tid, x, y, cap, img, true, name)
		c.image = g.love.graphics.newImage("assets/"..c.img)
		M.chesses[c.id] = c
		local grid, gx, gy = g.get_grid(c.x, c.y)
		print("id:", id, "cap:", cap, "tid:", tid, "x:", x, "y:", y, ",gx:", gx, ",gy:", gy, "name:", name, "grid:", (grid + 1))
		M.grid_chess_map[grid + 1] = c
	end
end

M.init = function ()
	print("on chessboard init")
	g.love.window.setMode(g.win_width, g.win_height)
	g.love.window.setTitle(g.title)

	-- 初始化阵营
	math.randomseed(os.time())
	-- 我方阵营(颜色), 1-红, 2-黑
	M.our_cap = math.random(2)
	-- 对方阵营
	if M.our_cap == 1 then M.other_cap = 2 else M.other_cap = 1 end

	-- 初始化棋子
	init_chesses(M.our_cap)
	init_chesses(M.other_cap)
	-- 初始化玩家
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

M.mouse_pressed = function(x, y)
	local grid, gx, gy = g.get_grid(x, y)
	local grid_chess = M.grid_chess_map[grid + 1]
	if grid_chess then
		-- 点中棋子
		grid_chess:detail()
		if grid_chess.alive == false then
			-- 选中已死棋子
			return
		end
		print("mouse_pressed, cid:", grid_chess.id, ",cap:", grid_chess.cap, ",ourcap:", M.our_cap, ",x:", x, ",y:", y, ",gx:", gx, ",gy:", gy)
		-- if grid_chess.cap == M.our_cap then
			-- 点中我方棋子
			grid_chess:select()
			M.chess_selected = grid_chess
			-- return
		-- else
		-- 	-- 点中对方棋子
		-- 	-- 若之前已选中了我方棋子, 则吃子
		-- 	return
		-- end
	else
		-- 点中空格子
		-- 若之前已选中我方棋子，则移动到该新格子
		print("M.chess_selected:", M.chess_selected, ",ourcap:", M.our_cap)
		-- if M.chess_selected and M.chess_selected.cap == M.our_cap then
		if M.chess_selected then
			local ox = M.chess_selected.x
			local oy = M.chess_selected.y
			local og, _, _ = g.get_grid(ox, oy)

			local c = M.chesses[M.chess_selected.id]
			c.x = gx
			c.y = gy
			M.grid_chess_map[grid + 1] = c
			M.grid_chess_map[og + 1] = nil
			M.chess_selected = nil
			print("move,ox:", ox, ",oy:", oy, ",nx:", gx, ",ny:", gy, ",x:", x, ",y:", y)
		end
		return
	end
end

return M
