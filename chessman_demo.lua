local chess = require "chessman"

local c0 = chess:new()
c0:init(0, 6, 0, 0, 0, "img-c0", true, "c0")
local c1 = chess:new()
c1:init(1, 1, 1, 0, "img-c1", true, "c1")
c0:detail()
c1:detail()
