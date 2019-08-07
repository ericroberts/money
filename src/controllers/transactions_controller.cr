require "kemal"
require "../plaid/account"
require "../plaid/transaction"

get "/transactions" do
  request = HTTP::Client.post(
    "https://sandbox.plaid.com/transactions/get",
    headers: HTTP::Headers{"Content-Type" => "application/json"},
    body: {
      client_id: ENV["PLAID_CLIENT_ID"],
      secret: ENV["PLAID_SECRET"],
      access_token: File.open("access_token.json") do |file|
        JSON.parse(file)["access_token"]
      end,
      start_date: Time.new(2019, 1, 1).to_s("%Y-%m-%d"),
      end_date: Time.now.to_s("%Y-%m-%d")
    }.to_json
  )
  json = request.body
  parsed_json = JSON.parse(json)
  accounts = parsed_json["transactions"]
    .as_a
    .group_by { |t| t["account_id"] }
    .map do |account_id, transactions|
      Plaid::Account.from_json(
        parsed_json["accounts"]
          .as_a
          .find { |a| a["account_id"] == account_id },
        transactions,
      )
    end

  render(
    "src/templates/transactions/index.ecr",
    "src/templates/layouts/application.ecr",
  )
end

post "/access_token" do |env|
  puts env.params.json["public_token"]
  request = HTTP::Client.post(
    "https://sandbox.plaid.com/item/public_token/exchange",
    headers: HTTP::Headers{"Content-Type" => "application/json"},
    body: {
      client_id: ENV["PLAID_CLIENT_ID"],
      secret: ENV["PLAID_SECRET"],
      public_token: env.params.json["public_token"],
    }.to_json
  )
  File.write("access_token.json", request.body)
  env.redirect "/"
end
