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
	[10] = {0, 5, 0 + M.board_edge_width + M.grid_size * 1, M.win_height - M.grid_size * 3 + M.board_edge_width, "红左炮"},
	[11] = {0, 5, 0 + M.board_edge_width + M.grid_size * 7, M.win_height - M.grid_size * 3 + M.board_edge_width, "红右炮"},
	[12] = {0, 6, 0 + M.board_edge_width + M.grid_size * 0, M.win_height - M.grid_size * 4 + M.board_edge_width, "红兵1"},
	[13] = {0, 6, 0 + M.board_edge_width + M.grid_size * 2, M.win_height - M.grid_size * 4 + M.board_edge_width, "红兵2"},
	[14] = {0, 6, 0 + M.board_edge_width + M.grid_size * 4, M.win_height - M.grid_size * 4 + M.board_edge_width, "红兵3"},
	[15] = {0, 6, 0 + M.board_edge_width + M.grid_size * 6, M.win_height - M.grid_size * 4 + M.board_edge_width, "红兵4"},
	[16] = {0, 6, 0 + M.board_edge_width + M.grid_size * 8, M.win_height - M.grid_size * 4 + M.board_edge_width, "红兵5"},

	[17] = {1, 0, 0 + M.board_edge_width + M.grid_size * 0, M.board_edge_width, "黑左车"},
	[18] = {1, 1, 0 + M.board_edge_width + M.grid_size * 1, M.board_edge_width, "黑左马"},
	[19] = {1, 2, 0 + M.board_edge_width + M.grid_size * 2, M.board_edge_width, "黑左相"},
	[20] = {1, 3, 0 + M.board_edge_width + M.grid_size * 3, M.board_edge_width, "黑左士"},
	[21] = {1, 4, 0 + M.board_edge_width + M.grid_size * 4, M.board_edge_width, "黑将"},
	[22] = {1, 3, 0 + M.board_edge_width + M.grid_size * 5, M.board_edge_width, "黑右士"},
	[23] = {1, 2, 0 + M.board_edge_width + M.grid_size * 6, M.board_edge_width, "黑右相"},
	[24] = {1, 1, 0 + M.board_edge_width + M.grid_size * 7, M.board_edge_width, "黑右马"},
	[25] = {1, 0, 0 + M.board_edge_width + M.grid_size * 8, M.board_edge_width, "黑右车"},
	[26] = {1, 5, 0 + M.board_edge_width + M.grid_size * 1, M.grid_size * 2 + M.board_edge_width, "黑左炮"},
	[27] = {1, 5, 0 + M.board_edge_width + M.grid_size * 7, M.grid_size * 2 + M.board_edge_width, "黑右炮"},
	[28] = {1, 6, 0 + M.board_edge_width + M.grid_size * 0, M.grid_size * 3 + M.board_edge_width, "黑兵1"},
	[29] = {1, 6, 0 + M.board_edge_width + M.grid_size * 2, M.grid_size * 3 + M.board_edge_width, "黑兵2"},
	[30] = {1, 6, 0 + M.board_edge_width + M.grid_size * 4, M.grid_size * 3 + M.board_edge_width, "黑兵3"},
	[31] = {1, 6, 0 + M.board_edge_width + M.grid_size * 6, M.grid_size * 3 + M.board_edge_width, "黑兵4"},
	[32] = {1, 6, 0 + M.board_edge_width + M.grid_size * 8, M.grid_size * 3 + M.board_edge_width, "黑兵5"},
}

-- 根据坐标得到棋盘格子位置编号
M.get_grid_idx = function (x, y)
	-- 横向格子坐标
	local gx
	-- 纵向格子编号
	local gy
	if x - M.board_edge_width < 0 then
		-- 超出左边界，则横向格子编号 = 0
		gx = 1
	else
		gx = math.floor((x - M.board_edge_width) / M.grid_size)
	end

	if y - M.board_edge_width < 0 then
		-- 超出上边界， 则纵向格子编号 = 0
		gy = 1
	else
		gy = math.floor((y - M.board_edge_width) / M.grid_size)
	end
	return gy * 9 + gx
end

-- local ca = {...}
-- local gx = math.floor((ca[1] - M.board_edge_width) / M.grid_size)
-- local gy = math.floor((ca[2] - M.board_edge_width) / M.grid_size)
-- print("gx", gx, "gy", gy, "ca1", ca[1], "ca2", ca[2])

return M
