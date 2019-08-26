require "kemal"
require "../../plaid/account"
require "../../plaid/transaction"
require "../../repositories/transaction"

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

post "/bulk_expenses" do |env|
  body = env.request.body.as(IO).gets_to_end
  params = body.split("&").map { |key_and_value|
    full_key, value =
      key_and_value
        .split("=", 2)
        .map { |v| URI.unescape(v, plus_to_space: true) }
    id, key = full_key.split("-", 2)
    {id, key, value}
  }.group_by { |id, _, _| id }.map do |_, keys_and_values|
    keys_and_values.reduce({} of String => String) do |transaction_data, (_, key, value)|
      transaction_data.merge({ key => value })
    end
  end
  params.each do |transaction_data|
    Repositories::Transaction.create(
      date: Time.parse(
        transaction_data["date"],
        "%Y-%m-%d",
        Time::Location::UTC,
      ),
      amount: Money.new(transaction_data["amount"].to_f(64) * 100, "CAD"),
      description: transaction_data["name"].as(String),
      category: transaction_data["category"].as(String),
    )
  end
  env.redirect "/"
end
