package.cpath="./?.dll"

local https = require('https')
local json = require('json')
local config = require('config')
local game = require('lootlocker.game')

local info
local sdk

function love.load()
    sdk = game({
        https = https,
        json = json,
        config = config
    })
    local response = sdk.createSession('Oskar', 'android')
    info = response.session_token
    if response.success then
        response = sdk.submitXp(100)
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
