require "kemal"
require "../forms/transaction"
require "../repositories/transaction"
require "../ui/forms/transaction"

repository = Repositories::Transaction

post "/expenses" do |env|
  builder = Forms::Transaction.build(
    date: env.params.body["date"],
    amount: env.params.body["amount"],
    description: env.params.body["description"],
    category: env.params.body["category"],
    type: env.params.body["type"],
  )

  if builder.valid?
    repository.create_from_model(builder.to_model)
    env.redirect "/"
  else
    expenses = repository.this_month.order(:date)
    form = UI::Forms::Transaction.build(builder)
    render "src/templates/home.ecr", "src/templates/layouts/application.ecr"
  end
end

post "/expenses/:id" do |env|
  if env.params.body["_method"].as(String).upcase == "DELETE"
    repository.delete(env.params.url["id"].as(String))
    env.redirect "/"
  end
end
