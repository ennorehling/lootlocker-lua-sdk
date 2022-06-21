local session_token = 'll-session-token'

local json = require 'json'
local https = {
	request = function(url, options)
		if url:match('/game/v2/session$') then
			return 200, json.encode({
				success = true,
				session_token = session_token,
			}), {}
		end
		return 404, '', {}
	end
}
insulate("lootlocker game sdk", function()
	game = require("lootlocker.game")
	sdk = game({
		json = json,
		https = https,
		config = {
			game_key = 'api-key',
			game_version = '4.2',
			development_mode = true
		}
	})
	it("creates a session", function()
		assert.is_not_nil(sdk)
		assert.are.equal(session_token, sdk.createSession().session_token)
	end)
end)
