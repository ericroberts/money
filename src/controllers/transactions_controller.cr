require "kemal"
require "../builders/transaction"
require "../repositories/transaction"
require "../inputs/date"
require "../inputs/money"
require "../inputs/text"

post "/expenses" do |env|
  builder = Builders::Transaction.new(
    date: env.params.body["date"],
    amount: env.params.body["amount"],
    description: env.params.body["description"],
    category: env.params.body["category"],
  )

  if builder.valid?
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
  else
    expenses = Repositories::Transaction.this_month.order(:date)
    errors = builder.errors
    transaction_form = Forms::Transaction.new(builder)
    render "src/templates/home.ecr", "src/templates/layouts/application.ecr"
  end
end

post "/expenses/:id" do |env|
  if env.params.body["_method"].as(String).upcase == "DELETE"
    Repositories::Transaction.delete(env.params.url["id"])
    env.redirect "/"
  end
end
