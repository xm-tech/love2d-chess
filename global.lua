local M = {
	win_width = 520,
	win_height = 576,
	title = "中国象棋",

	grid_size = 56,
	board_edge_width = 8,
	board_width = 8 + 56*9 + 8,
	board_height = 8 + 56*10 + 8,
}

-- [棋子ID]={棋子阵营, 棋子类别，x, y, 名称}, 棋子阵营: 0-红, 1-黑
M.chess_both = {
	[1] = {0, 0, 0 + M.board_edge_width + M.grid_size * 0, M.win_height - M.grid_size + M.board_edge_width, "红左车"},
	[2] = {0, 1, 0 + M.board_edge_width + M.grid_size * 1, M.win_height - M.grid_size + M.board_edge_width, "红左马"},
	[3] = {0, 2, 0 + M.board_edge_width + M.grid_size * 2, M.win_height - M.grid_size + M.board_edge_width, "红左相"},
	[4] = {0, 3, 0 + M.board_edge_width + M.grid_size * 3, M.win_height - M.grid_size + M.board_edge_width, "红左士"},
	[5] = {0, 4, 0 + M.board_edge_width + M.grid_size * 4, M.win_height - M.grid_size + M.board_edge_width, "红将"},
	[6] = {0, 3, 0 + M.board_edge_width + M.grid_size * 5, M.win_height - M.grid_size + M.board_edge_width, "红右士"},
	[7] = {0, 2, 0 + M.board_edge_width + M.grid_size * 6, M.win_height - M.grid_size + M.board_edge_width, "红右相"},
	[8] = {0, 1, 0 + M.board_edge_width + M.grid_size * 7, M.win_height - M.grid_size + M.board_edge_width, "红右马"},
	[9] = {0, 0, 0 + M.board_edge_width + M.grid_size * 8, M.win_height - M.grid_size + M.board_edge_width, "红右车"},

	[10] = {0, 5, 0 + M.board_edge_width + M.grid_size * 1, M.win_height - M.grid_size * 3 + M.board_edge_width, "红右炮"},
	[11] = {0, 5, 0 + M.board_edge_width + M.grid_size * 7, M.win_height - M.grid_size * 3 + M.board_edge_width, "红右炮"},

	[12] = {0, 6, 0 + M.board_edge_width + M.grid_size * 0, M.win_height - M.grid_size * 4 + M.board_edge_width, "红兵1"},
	[13] = {0, 6, 0 + M.board_edge_width + M.grid_size * 2, M.win_height - M.grid_size * 4 + M.board_edge_width, "红兵2"},
	[14] = {0, 6, 0 + M.board_edge_width + M.grid_size * 4, M.win_height - M.grid_size * 4 + M.board_edge_width, "红兵3"},
	[15] = {0, 6, 0 + M.board_edge_width + M.grid_size * 6, M.win_height - M.grid_size * 4 + M.board_edge_width, "红兵4"},
	[16] = {0, 6, 0 + M.board_edge_width + M.grid_size * 8, M.win_height - M.grid_size * 4 + M.board_edge_width, "红兵5"},
}

return M




-- // 己方16颗棋子出生点
-- var ChessBothA = [16][3]int{
-- 	// {棋子类别, x, y}
-- 	{0, 0 + 8 + 56*0, 576 - 56 + 8},                // 车
-- 	{1, 0 + 8 + 56*1, 576 - 56 + 8},                // 左马
-- 	{2, 0 + 8 + 56*2, 576 - 56 + 8},                // 左相
-- 	{3, 0 + 8 + 56*3, 576 - 56 + 8},                // 左士
-- 	{4, 0 + 8 + 56*4, 576 - 56 + 8},                // 将
-- 	{3, 0 + 8 + 56*5, 576 - 56 + 8},                // 右士
-- 	{2, 0 + 8 + 56*6, 576 - 56 + 8},                // 右相
-- 	{1, 0 + 8 + 56*7, 576 - 56 + 8},                // 右马
-- 	{0, 0 + 8 + 56*8, 576 - 56 + 8},                // 右车
-- 	{5, 0 + 8 + 56*1, 576 - 56 - 56 - 56 + 8},      // 左炮
-- 	{5, 0 + 8 + 56*7, 576 - 56 - 56 - 56 + 8},      // 右炮
-- 	{6, 0 + 8 + 56*0, 576 - 56 - 56 - 56 - 56 + 8}, // 兵1
-- 	{6, 0 + 8 + 56*2, 576 - 56 - 56 - 56 - 56 + 8}, // 兵2
-- 	{6, 0 + 8 + 56*4, 576 - 56 - 56 - 56 - 56 + 8}, // 兵3
-- 	{6, 0 + 8 + 56*6, 576 - 56 - 56 - 56 - 56 + 8}, // 兵4
-- 	{6, 0 + 8 + 56*8, 576 - 56 - 56 - 56 - 56 + 8}, // 兵5
-- }

-- // 对方16颗棋子出生点
-- var ChessBothB = [16][3]int{
-- 	// {棋子类别, x, y}
-- 	{0, 0 + 8 + 56*0, 8},        // 车
-- 	{1, 0 + 8 + 56*1, 8},        // 左马
-- 	{2, 0 + 8 + 56*2, 8},        // 左相
-- 	{3, 0 + 8 + 56*3, 8},        // 左士
-- 	{4, 0 + 8 + 56*4, 8},        // 将
-- 	{3, 0 + 8 + 56*5, 8},        // 右士
-- 	{2, 0 + 8 + 56*6, 8},        // 右相
-- 	{1, 0 + 8 + 56*7, 8},        // 右马
-- 	{0, 0 + 8 + 56*8, 8},        // 右车
-- 	{5, 0 + 8 + 56*1, 8 + 56*2}, // 左炮
-- 	{5, 0 + 8 + 56*7, 8 + 56*2}, // 右炮
-- 	{6, 0 + 8 + 56*0, 8 + 56*3}, // 兵1
-- 	{6, 0 + 8 + 56*2, 8 + 56*3}, // 兵2
-- 	{6, 0 + 8 + 56*4, 8 + 56*3}, // 兵3
-- 	{6, 0 + 8 + 56*6, 8 + 56*3}, // 兵4
-- 	{6, 0 + 8 + 56*8, 8 + 56*3}, // 兵5
-- }

-- // 棋盘上的棋子编号
-- var PosChesses = [90]int{
-- 	-1, -1, -1, -1, -1, -1, -1, -1, -1,
-- 	-1, -1, -1, -1, -1, -1, -1, -1, -1,
-- 	-1, -1, -1, -1, -1, -1, -1, -1, -1,
-- 	-1, -1, -1, -1, -1, -1, -1, -1, -1,
-- 	-1, -1, -1, -1, -1, -1, -1, -1, -1,
-- 	-1, -1, -1, -1, -1, -1, -1, -1, -1,
-- 	-1, -1, -1, -1, -1, -1, -1, -1, -1,
-- 	-1, -1, -1, -1, -1, -1, -1, -1, -1,
-- 	-1, -1, -1, -1, -1, -1, -1, -1, -1,
-- 	-1, -1, -1, -1, -1, -1, -1, -1, -1,
-- }


