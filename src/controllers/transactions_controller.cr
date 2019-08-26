require "kemal"
require "../repositories/transaction"

post "/expenses" do |env|
  Repositories::Transaction.create(
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
    Repositories::Transaction.delete(env.params.url["id"])
    env.redirect "/"
  end
end
