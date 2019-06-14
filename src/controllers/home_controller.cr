require "kemal"
require "money"
require "dotenv"
require "../models/expense"
require "../repositories/expense"

Dotenv.load

get "/" do
  expenses = Repositories::Expense.this_month.order(:date)
  render "src/templates/home.ecr", "src/templates/layouts/application.ecr"
end

class Account
  include JSON::Serializable

  getter :name, :transactions

  property name : String
  property transactions : Array(Transaction)

  def initialize(
    name : String,
    transactions : Array(Transaction)
  )
    @name = name
    @transactions = transactions
  end
end

class Transaction
  include JSON::Serializable

  getter :id, :date, :name, :amount, :categories

  property id : String
  property date : Time
  property name : String
  property amount : Money
  property categories : Array(String)

  def initialize(
    id : String,
    date : Time,
    name : String,
    amount : Money,
    categories : Array(String),
  )
    @id = id
    @date = date
    @name = name
    @amount = amount
    @categories = categories
  end
end

def convert_to_money(amount)
  Money.new(amount.to_s.to_f * 100, "CAD")
end

def build_account(json, transactions_json)
  raise "Account json must be provided" unless json
  Account.new(
    name: json["name"].as_s,
    transactions: transactions_json.map do |t_json|
      build_transaction(t_json)
    end
  )
end

def build_transaction(json)
  Transaction.new(
    id: json["transaction_id"].as_s,
    date: Time.parse(
      json["date"].to_s,
      "%Y-%m-%d",
      Time::Location::UTC,
    ),
    amount: Money.new(json["amount"].to_s.to_f * 100, "CAD"),
    name: json["name"].as_s,
    categories: json["category"].as_a.map { |c| c.as_s },
  )
end

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
      build_account(
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

post "/expenses" do |env|
  Repositories::Expense.create(
    date: Time.parse(
      env.params.body["date"].as(String),
      "%Y-%m-%d",
      Time::Location::UTC,
    ),
    amount: Money.new(env.params.body["amount"].to_f(64) * 100, "CAD"),
    description: env.params.body["description"].as(String),
    category: env.params.body["category"].as(String),
  )
  env.redirect "/"
end

post "/expenses/:id" do |env|
  if env.params.body["_method"].as(String).upcase == "DELETE"
    Repositories::Expense.delete(env.params.url["id"])
    env.redirect "/"
  end
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

alias Params = Hash(String, Params | String)

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
  pp params
end

Kemal.run
