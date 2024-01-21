local M = {
	love = require "love",

	win_width = 520,
	win_height = 576,
	title = "中国象棋",

	grid_size = 56,
	board_edge_width = 8,
	board_width = 8 + 56*9 + 8,
	board_height = 8 + 56*10 + 8,
-- 311, 121 -> 
}

-- 棋子出生点
M.chess_both = {
	-- 己方
	[1] = {
		-- {棋子ID, 棋子类别，x, y, 名称}
		[1] = {100, 0, 0 + M.board_edge_width + M.grid_size * 0, M.win_height - M.grid_size + M.board_edge_width, "左车"},
		[2] = {101, 1, 0 + M.board_edge_width + M.grid_size * 1, M.win_height - M.grid_size + M.board_edge_width, "左马"},
		[3] = {102, 2, 0 + M.board_edge_width + M.grid_size * 2, M.win_height - M.grid_size + M.board_edge_width, "左相"},
		[4] = {103, 3, 0 + M.board_edge_width + M.grid_size * 3, M.win_height - M.grid_size + M.board_edge_width, "左士"},
		[5] = {104, 4, 0 + M.board_edge_width + M.grid_size * 4, M.win_height - M.grid_size + M.board_edge_width, "将"},
		[6] = {105, 3, 0 + M.board_edge_width + M.grid_size * 5, M.win_height - M.grid_size + M.board_edge_width, "右士"},
		[7] = {106, 2, 0 + M.board_edge_width + M.grid_size * 6, M.win_height - M.grid_size + M.board_edge_width, "右相"},
		[8] = {107, 1, 0 + M.board_edge_width + M.grid_size * 7, M.win_height - M.grid_size + M.board_edge_width, "右马"},
		[9] = {108, 0, 0 + M.board_edge_width + M.grid_size * 8, M.win_height - M.grid_size + M.board_edge_width, "右车"},
		[10] = {109,5, 0 + M.board_edge_width + M.grid_size * 1, M.win_height - M.grid_size * 3 + M.board_edge_width, "左炮"},
		[11] = {110,5, 0 + M.board_edge_width + M.grid_size * 7, M.win_height - M.grid_size * 3 + M.board_edge_width, "右炮"},
		[12] = {111,6, 0 + M.board_edge_width + M.grid_size * 0, M.win_height - M.grid_size * 4 + M.board_edge_width, "兵1"},
		[13] = {112,6, 0 + M.board_edge_width + M.grid_size * 2, M.win_height - M.grid_size * 4 + M.board_edge_width, "兵2"},
		[14] = {113,6, 0 + M.board_edge_width + M.grid_size * 4, M.win_height - M.grid_size * 4 + M.board_edge_width, "兵3"},
		[15] = {114,6, 0 + M.board_edge_width + M.grid_size * 6, M.win_height - M.grid_size * 4 + M.board_edge_width, "兵4"},
		[16] = {115,6, 0 + M.board_edge_width + M.grid_size * 8, M.win_height - M.grid_size * 4 + M.board_edge_width, "兵5"},
	},
	-- 对方
	[2] = {
		[1] = {200,0, 0 + M.board_edge_width + M.grid_size * 0, M.board_edge_width, "左车"},
		[2] = {201,1, 0 + M.board_edge_width + M.grid_size * 1, M.board_edge_width, "左马"},
		[3] = {202,2, 0 + M.board_edge_width + M.grid_size * 2, M.board_edge_width, "左相"},
		[4] = {203,3, 0 + M.board_edge_width + M.grid_size * 3, M.board_edge_width, "左士"},
		[5] = {204,4, 0 + M.board_edge_width + M.grid_size * 4, M.board_edge_width, "将"},
		[6] = {205,3, 0 + M.board_edge_width + M.grid_size * 5, M.board_edge_width, "右士"},
		[7] = {206,2, 0 + M.board_edge_width + M.grid_size * 6, M.board_edge_width, "右相"},
		[8] = {207,1, 0 + M.board_edge_width + M.grid_size * 7, M.board_edge_width, "右马"},
		[9] = {208,0, 0 + M.board_edge_width + M.grid_size * 8, M.board_edge_width, "右车"},
		[10] = {209,5, 0 + M.board_edge_width + M.grid_size * 1, M.grid_size * 2 + M.board_edge_width, "左炮"},
		[11] = {210,5, 0 + M.board_edge_width + M.grid_size * 7, M.grid_size * 2 + M.board_edge_width, "右炮"},
		[12] = {211,6, 0 + M.board_edge_width + M.grid_size * 0, M.grid_size * 3 + M.board_edge_width, "兵1"},
		[13] = {212,6, 0 + M.board_edge_width + M.grid_size * 2, M.grid_size * 3 + M.board_edge_width, "兵2"},
		[14] = {213,6, 0 + M.board_edge_width + M.grid_size * 4, M.grid_size * 3 + M.board_edge_width, "兵3"},
		[15] = {214,6, 0 + M.board_edge_width + M.grid_size * 6, M.grid_size * 3 + M.board_edge_width, "兵4"},
		[16] = {215,6, 0 + M.board_edge_width + M.grid_size * 8, M.grid_size * 3 + M.board_edge_width, "兵5"},
	}

}

-- 根据坐标得到棋盘格子位置编号
M.get_grid = function (x, y)
	-- 横向格子编号
	local gx
	-- 纵向格子编号
	local gy
	if x - M.board_edge_width < 0 then
		-- 超出左边界，则横向格子编号 = 0
		gx = 0
	else
		gx = math.floor((x - M.board_edge_width) / M.grid_size)
	end

	if y - M.board_edge_width < 0 then
		-- 超出上边界， 则纵向格子编号 = 0
		gy = 0
	else
		gy = math.floor((y - M.board_edge_width) / M.grid_size)
	end
	local nx = gx * M.grid_size + M.board_edge_width
	local ny = gy * M.grid_size + M.board_edge_width
	-- print("getgrid,x:", x, ",y:", y, ",nx: ", nx, ",ny:", ny)
	if ny > 300 then
		-- fix the y of myself
		ny = ny +  2 * M.board_edge_width
	end
	return gy * 9 + gx, nx, ny
end

-- local ca = {...}
-- local gx = math.floor((ca[1] - M.board_edge_width) / M.grid_size)
-- local gy = math.floor((ca[2] - M.board_edge_width) / M.grid_size)
-- print("gx", gx, "gy", gy, "ca1", ca[1], "ca2", ca[2])

return M
