local g = require "global"

-- 棋盘
local M = {
	chess_board_img = g.love.graphics.newImage("assets/ChessBoard.png"),
	-- 棋局玩家
	players = {},
	-- 所有棋子
	chesses = {},
	-- 格子棋子映射
	grid_chess_map = {},
	-- 选中的棋子
	chess_selected = nil,
	-- 目标位置
	target_pos = {},
	-- 我方颜色
	our_color = nil,
	-- 对方颜色
	other_color = nil,
}


local function isMyChess(chess)
	if chess.color == M.our_color then
		return true
	else
		return false
	end
end



-- 初始化棋子数据, cap 阵营，只决定棋子的位置，不决定自己的棋子颜色, 己方棋子始终在下面
local function init_chesses(cap)
	local color = M.other_color
	if cap == 1 then
		color = M.our_color
	end
	local chess = require "chess"
	-- 此处， g.chess_both 下标始终是自己的取1， 对方的取 2， 因为 1 的Y坐标 大
	for _, chesscnf in pairs(g.chess_both[cap]) do
		-- chesscnf: {棋子类别，x, y, 名称}
		local c = chess:new()
		-- id = id + 1
		local id = chesscnf[1]
		local tid = chesscnf[2]
		local x = chesscnf[3]
		local y = chesscnf[4]
		local name = chesscnf[5]
		local img = (color-1).."-"..tid..".png"
		print("id:", id, ",tid:", tid, ",x:", x, ",y:", y, ",name:", name, ",img:", img)
		-- id, tid, x, y, cap, img, alive, name
		c:init(id, tid, x, y, cap, img, true, name)
		c.color = color
		c.image = g.love.graphics.newImage("assets/"..c.img)
		M.chesses[c.id] = c
		local grid, gx, gy = g.get_grid(c.x, c.y)
		-- print("id:", id, "cap:", cap, "tid:", tid, "x:", x, "y:", y, ",gx:", gx, ",gy:", gy, "name:", name, "grid:", (grid + 1))
		M.grid_chess_map[grid + 1] = c
	end
end

M.init = function ()
	print("on chessboard init")
	g.love.window.setMode(g.win_width, g.win_height)
	g.love.window.setTitle(g.title)

	-- 初始化颜色
	math.randomseed(os.time())
	-- 我方颜色, 1-红, 2-黑
	M.our_color = math.random(2)
	-- 对方颜色
	if M.our_color == 1 then
		M.other_color = 2
	else
		M.other_color = 1
	end

	print("our_color:", M.our_color, ",other_color:", M.other_color)
	-- 初始化己方棋子
	init_chesses(1)
	-- 初始化对方棋子
	init_chesses(2)
	-- 初始化玩家
end

M.draw = function ()
	-- 画棋盘
	g.love.graphics.draw(M.chess_board_img, M.x, M.y)

	-- 画棋子
	for _, c in pairs(M.chesses) do
		if c.alive then
			g.love.graphics.draw(c.image, c.x, c.y)
		end
	end
end

M.mouse_pressed = function(x, y)
	local grid, ngx, ngy = g.get_grid(x, y)
	local grid_chess = M.grid_chess_map[grid + 1]
	if grid_chess then
		-- 点中棋子
		print("mouse_pressed, cid:", grid_chess.id, ",color:", grid_chess.color, ",other_color:", M.other_color, ",x:", x, ",y:", y, ",ngx:", ngx, ",ngy:", ngy)

		-- 若是对方棋子，且之前没选子，则不能选对方该子
		if isMyChess(grid_chess) == false and M.chess_selected == nil then
			return
		end

		-- 若上次选中的是自己的子,且本次选中对方的子，则吃子
		if (M.chess_selected ~= nil) and (isMyChess(M.chess_selected) == true) and (isMyChess(grid_chess) == false) then
			-- 吃子
			grid_chess:die()
			-- 我方子位置更新为被吃子
			local ox = M.chess_selected.x
			local oy = M.chess_selected.y
			local og, ogx, ogy = g.get_grid(ox, oy)
			M.chess_selected.x = grid_chess.x
			M.chess_selected.y = grid_chess.y
			M.grid_chess_map[grid + 1] = M.chess_selected
			M.grid_chess_map[og + 1] = nil
			M.chess_selected = nil
		end


		-- 若之前未曾选子，且当前子是自己的子，则选中
		grid_chess:select()
		M.chess_selected = grid_chess
	else
		-- 点中空格子
		-- 若之前已选中我方棋子，则移动到该新格子
		print("M.chess_selected:", M.chess_selected, ",our_color:", M.our_color, ",x:", x, ",y:", y)
		if M.chess_selected then
			local ox = M.chess_selected.x
			local oy = M.chess_selected.y
			local og, ogx, ogy = g.get_grid(ox, oy)

			local c = M.chesses[M.chess_selected.id]
			c.x = ngx
			c.y = ngy
			M.grid_chess_map[grid + 1] = c
			M.grid_chess_map[og + 1] = nil
			print("move,cid:",M.chess_selected.id, ",ox:", ox, ",ogx:", ogx, ",oy:", oy, ",ogy:", ogy, ",nx:", x, ",ny:", y, ",ngx:", ngx, ",ngy:", ngy)
			M.chess_selected = nil
		end
		return
	end
end

return M
