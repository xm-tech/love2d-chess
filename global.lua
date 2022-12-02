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

	[17] = {1, 0, 0 + M.board_edge_width + M.grid_size * 0, M.board_edge_width, "红左车"},
	[18] = {1, 1, 0 + M.board_edge_width + M.grid_size * 1, M.board_edge_width, "红左马"},
	[19] = {1, 2, 0 + M.board_edge_width + M.grid_size * 2, M.board_edge_width, "红左相"},
	[20] = {1, 3, 0 + M.board_edge_width + M.grid_size * 3, M.board_edge_width, "红左士"},
	[21] = {1, 4, 0 + M.board_edge_width + M.grid_size * 4, M.board_edge_width, "红将"},
	[22] = {1, 3, 0 + M.board_edge_width + M.grid_size * 5, M.board_edge_width, "红右士"},
	[23] = {1, 2, 0 + M.board_edge_width + M.grid_size * 6, M.board_edge_width, "红右相"},
	[24] = {1, 1, 0 + M.board_edge_width + M.grid_size * 7, M.board_edge_width, "红右马"},
	[25] = {1, 0, 0 + M.board_edge_width + M.grid_size * 8, M.board_edge_width, "红右车"},
	[26] = {1, 5, 0 + M.board_edge_width + M.grid_size * 1, M.grid_size * 2 + M.board_edge_width, "红右炮"},
	[27] = {1, 5, 0 + M.board_edge_width + M.grid_size * 7, M.grid_size * 2 + M.board_edge_width, "红右炮"},
	[28] = {1, 6, 0 + M.board_edge_width + M.grid_size * 0, M.grid_size * 3 + M.board_edge_width, "红兵1"},
	[29] = {1, 6, 0 + M.board_edge_width + M.grid_size * 2, M.grid_size * 3 + M.board_edge_width, "红兵2"},
	[30] = {1, 6, 0 + M.board_edge_width + M.grid_size * 4, M.grid_size * 3 + M.board_edge_width, "红兵3"},
	[31] = {1, 6, 0 + M.board_edge_width + M.grid_size * 6, M.grid_size * 3 + M.board_edge_width, "红兵4"},
	[32] = {1, 6, 0 + M.board_edge_width + M.grid_size * 8, M.grid_size * 3 + M.board_edge_width, "红兵5"},
}

return M

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
