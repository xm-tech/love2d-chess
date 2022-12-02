-- 棋盘
local M = {
	chess_board = love.graphics.newImage("assets/ChessBoard.png"),
	x = 0,
	y = 0,
}

local g = require "global"
M.init = function ()
	print("on chessboard init")
	love.window.setMode(g.win_width, g.win_height)
	love.window.setTitle(g.title)
end

M.draw = function ()
	love.graphics.draw(M.chess_board, M.x, M.y)
end

return M
