local mock_json = {
	encode = function(o)
		return tostring(o)
	end,
	decode = function(s)
		return { o }
	end
}
local mock_https = {
	request = function(url, options)
		return 404, options.data, {}
	end
}
insulate("lootlocker game sdk", function()
	json = mock_json 
	https = mock_https
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
	describe("sessions", function()
		assert.is_not_nil(sdk)
		sdk.createSession()
		assert.is_not_nil(sdk.session_token)
	end)
end)
