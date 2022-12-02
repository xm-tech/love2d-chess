local love = require "love"
local chess_board = require "chessboard"

function love.load()
	print("welcom to love2d")
	chess_board.init()
end

function love.draw()
	chess_board.draw()
end

function love.mousepressed(x, y, button, istouch)
	chess_board.mouse_pressed(x, y, button, istouch)
end

