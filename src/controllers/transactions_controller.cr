require "kemal"
require "../forms/transaction"
require "../repositories/transaction"
require "../ui/forms/transaction"

repository = Repositories::Transaction

post "/expenses" do |env|
  form = Forms::Transaction.build(
    date: env.params.body["date"],
    amount: env.params.body["amount"],
    description: env.params.body["description"],
    category: env.params.body["category"],
    type: env.params.body["type"],
  )

  if form.valid?
    repository.create_from_model(form.to_model)
    env.redirect "/"
  else
    expenses = repository.this_month.order(:date)
    ui_form = form.to_ui_form
    render "src/templates/home.ecr", "src/templates/layouts/application.ecr"
  end
end

post "/expenses/:id" do |env|
  if env.params.body["_method"].as(String).upcase == "DELETE"
    repository.delete(env.params.url["id"].as(String))
    env.redirect "/"
  end
end
