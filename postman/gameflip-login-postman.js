// In Postman, create a new request as seen here:

// method: "GET"

// url: "https://production-gameflip.fingershock.com/api/v1/listing?limit=36&category=GIFTCARD&platform=xbox_live_gold&status=onsale&digital_deliverable=code&shipping_within_days=0,0&sort=onsale:desc&price=400,3500&accept_currency=USD"


// Pre-request Script
// NOTE: Postman Sandbox API reference: "Global functions (pm.*)"
// NOTE: https://learning.getpostman.com/docs/postman/scripts/postman_sandbox_api_reference/
var token_url = "https://production-gameflip.fingershock.com/login";
pm.sendRequest({
	url: token_url,
	method: 'POST'
}, function (err, res_login) {
	
	let login_json = res_login.json();
	// pm.environment.set("access_token", login_json.data.access_token);

	//==-- Test 1
	pm.test("Pre-request Script - pm.expect(res_login).to.have.property('code', 200);", function () {
		// res_login.to.have.status(200);
		pm.expect(res_login).to.have.property('code', 200);
	});
	//==-- Test 2
	pm.test("Pre-request Script - res_login.to.be.json", function () {
		pm.expect(res_login).to.be.json;
	});
	//==-- Test 3
	pm.test("Pre-request Script - res_login.to.not.have.jsonBody('error');", function () {
		pm.expect(res_login).to.not.have.jsonBody('error');
	});
	//==-- Test 4
	pm.test('Pre-request Script - check JSON response again against schema_pm_response', function() {
		var schema_pm_response = {
			"required": ["status","data"],
			"properties": {
				"status": {
					"type": "string",
					"minimum": 2,
					"maximum": 1000
				},
				"data": {
					"type": "object"
				}
			}
		};
		pm.expect(tv4.validate(login_json, schema_pm_response)).to.be.true;
	});
	//==-- Test 5
	pm.test('Pre-request Script - check JSON response against schema_pm_data', function() {
		var json_data = login_json.data;
		var schema_pm_data = {
			"required": ["access_token","me"],
			"properties": {
				"access_token": {
					"type": "string",
					"minimum": 10,
					"maximum": 1000
				},
				"me": {
					"type": "string",
					"minLength": 10,
					"maxLength": 1000
				}
			}
		};
		pm.expect(tv4.validate(login_json.data, schema_pm_data)).to.be.true;
	});
	//==-- Place token in environment var for later-use
	let response = login_json;
	if (response.hasOwnProperty('data')) {
		if (response.data.hasOwnProperty('access_token')) {
				postman.setEnvironmentVariable('gfl_access_token', response.data.access_token);
				console.log("Set environment Variable \"gfl_access_token\" to value \"{{gfl_access_token}}\"");
		}
		if (response.data.hasOwnProperty('me')) {
				postman.setEnvironmentVariable('gfl_me', response.data.me);
				console.log("Set environment Variable \"gfl_me\" to value \"{{gfl_me}}\"");
		}
	}
});