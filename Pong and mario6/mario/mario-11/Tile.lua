-- Tile.lua
Tile = {}
Tile.__index = Tile

function Tile:new(x, y, type)
    local tile = {
        x = x,
        y = y,
        type = type
        -- Add other properties as needed
    }
    setmetatable(tile, self)
    return tile
end

return Tile
