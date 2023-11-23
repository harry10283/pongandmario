--[[
    Super Mario Bros. Demo
    Author: Colton Ogden
    Original Credit: Nintendo

    Adds sound effects and music.
]]

-- global key-handling
love.keyboard.keysPressed = {}
love.keyboard.keysReleased = {}

push = require 'push'

require 'Map'
require 'Player'

-- close resolution to NES but 16:9
virtualWidth = 432
virtualHeight = 243

-- actual window resolution
windowWidth = 1280
windowHeight = 720

-- seed RNG
math.randomseed(os.time())

-- an object to contain our map data
map = Map:create()
local player = {}
-- performs initialization of all objects and data needed by program
function love.load()
    -- makes upscaling look pixel-y instead of blurry
    local gameWidth, gameHeight = 640, 480

    -- Set the window's actual resolution
    local windowWidth, windowHeight = 1280, 960
    push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- sets up a different, better-looking retro font as our default
    love.graphics.setFont(love.graphics.newFont('fonts/font.ttf', 8))

    -- sets up virtual screen resolution for an authentic retro feel
    push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {
        fullscreen = false,
        resizable = true
    })
    player = {
        -- your player properties and methods here
        -- for example, you might have something like player.x, player.y, player.update, etc.
        x = 100,
        y = 100,
        speed = 200,
        update = function(self, dt)
            -- your update logic here
        end,
        victory = false  -- assuming victory is a property of the player
    }
end


-- called whenever window is resized
function love.resize(w, h)
    push:resize(w, h)
end
-- global key pressed function
function love.keyboard.wasPressed(key)
    if (love.keyboard.keysPressed[key]) then
        return true
    else
        return false
    end
end

-- global key released function
function love.keyboard.wasReleased(key)
    if (love.keyboard.keysReleased[key]) then
        return true
    else
        return false
    end
end

-- called whenever a key is pressed
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

-- called whenever a key is released
function love.keyreleased(key)
    love.keyboard.keysReleased[key] = true
end

-- called every frame, with dt passed in as delta in time since last frame
function love.update(dt)
    -- Check if the player object exists before updating
    if player then
        player:update(dt)

        if player.victory then
            -- reset all keys pressed and released this frame
            love.keyboard.keysPressed = {}
            love.keyboard.keysReleased = {}
        end
    end
    player:update(dt)  
end
-- called each frame, used to render to the screen
function love.draw()
    -- begin virtual resolution drawing
    push:start()

    -- clear screen using Mario background blue
    love.graphics.clear(108, 140, 255, 255)
    love.graphics.rectangle("fill", player.x, player.y, 20, 20)
    -- renders our map object onto the screen
    love.graphics.translate(math.floor(-map.camX), math.floor(-map.camY))
    map:render()

    -- end virtual resolution
    push:finish()
end
