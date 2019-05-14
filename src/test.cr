require "json"
require "http"
require "dotenv"

Dotenv.load

access_token = File.open("access_token.json") do |file|
  JSON.parse(file)["access_token"]
end

request = HTTP::Client.post(
  "https://sandbox.plaid.com/auth/get",
  headers: HTTP::Headers{"Content-Type" => "application/json"},
  body: {
    client_id: ENV["PLAID_CLIENT_ID"],
    secret: ENV["PLAID_SECRET"],
    access_token: access_token,
  }.to_json
)

puts request.body
