local love = require "love"
local chess_board = require "chessboard"

function love.load()
	print("welcom to love2d")
	chess_board.init()
end

function love.draw()
	chess_board.draw()
end

