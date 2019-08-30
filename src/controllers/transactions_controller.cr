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
      date: builder.properties[:date].validated_value,
      amount: builder.properties[:amount].validated_value,
      description: builder.properties[:description].validated_value,
      category: builder.properties[:category].validated_value,
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
