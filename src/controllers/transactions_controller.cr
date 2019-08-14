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
