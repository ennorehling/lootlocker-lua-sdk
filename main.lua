package.cpath="./?.dll"

local https = require('https')
local json = require('json')
local config = require('config')

local modules = {
    https = https,
    json = json,
    config = config
}

local game
local info

function love.load()
    game = require('lootlocker.game')(modules)
    local response = game.createSession('Oskar', 'android')
    info = response.session_token
    if response.success then
        response = game.submitXp(100)
        if response.error then
            info = "error: " .. response.error
        else
            info = "info: " .. response.xp.current .. " XP"
        end
    end
end

function love.draw()
    love.graphics.setBackgroundColor(255, 255, 255)
    love.graphics.setColor(0, 0, 0)
    if info then
        love.graphics.print("Hello World: " .. info, 10, 10)
    end
end
