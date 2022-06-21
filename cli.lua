package.cpath="./?.so;./?.dll"
config = require 'config'
https = require 'https'
json = require 'json'
game = require 'lootlocker.game'

sdk = game({ https = https, json = json, config = config})
response = sdk.createSession()
print(response.session_key)
response = sdk.getPlayerInfo()
print(response.player_id)
response = sdk.setPlayerName('Enno')
print(response.name)
response = sdk.getPlayerName()
print(response.name)
