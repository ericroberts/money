require "kemal"
require "../forms/transaction"
require "../repositories/transaction"
require "../ui/forms/transaction"

post "/expenses" do |env|
  builder = Forms::Transaction.build(
    date: env.params.body["date"],
    amount: env.params.body["amount"],
    description: env.params.body["description"],
    category: env.params.body["category"],
    type: env.params.body["type"],
  )

  if builder.valid?
    Repositories::Transaction.create(
      date: Time.parse(
        env.params.body["date"].as(String),
        "%Y-%m-%d",
        Time::Location::UTC,
      ),
      amount: ::Money.new(env.params.body["amount"].to_f * 100, "CAD"),
      description: env.params.body["description"].as(String),
      category: env.params.body["category"].as(String),
    )
    env.redirect "/"
  else
    expenses = Repositories::Transaction.this_month.order(:date)
    form = UI::Forms::Transaction.build(builder)
    render "src/templates/home.ecr", "src/templates/layouts/application.ecr"
  end
end

post "/expenses/:id" do |env|
  if env.params.body["_method"].as(String).upcase == "DELETE"
    Repositories::Transaction.delete(env.params.url["id"].as(String))
    env.redirect "/"
  end
end
