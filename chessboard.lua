-- 棋盘
local M = {
	chess_board = love.graphics.newImage("assets/ChessBoard.png"),
	x = 0,
	y = 0,
	chesses = {},
}

local g = require "global"

local function init_chesses()
	local chess = require "chessman"

	-- 初始化所有棋子
	for idx, data in ipairs(g.chess_both) do
		-- {棋子阵营, 棋子类别，x, y, 名称}, 棋子阵营: 0-红, 1-黑
		local c = chess:new()
		c.idx = idx
		print("cap", data[1])
		print("type", data[2])
		print("x", data[3])
		print("y", data[4])
		print("name", data[5])
		c:init(data[2], data[3], data[4], data[1], data[1].."-"..data[2]..".png", true, data[5])
		c.image = love.graphics.newImage("assets/"..c.img)
		M.chesses[c.idx] = c
	end

end

M.init = function ()
	print("on chessboard init")
	love.window.setMode(g.win_width, g.win_height)
	love.window.setTitle(g.title)

	init_chesses()
end

M.draw = function ()
	love.graphics.draw(M.chess_board, M.x, M.y)
	for _, c in pairs(M.chesses) do
		if c.alive then
			love.graphics.draw(c.image, c.x, c.y)
		end
	end
end

return M
