local g = require "global"
local chess_board = require "chessboard"

function g.love.load()
	print("welcom to love2d")
	chess_board.init()
end

function g.love.draw()
	chess_board.draw()
end

function g.love.mousepressed(x, y, button, istouch)
	chess_board.mouse_pressed(x, y, button, istouch)
end

