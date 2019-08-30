require "kemal"
require "money"
require "../repositories/transaction"
require "../ui/forms/transaction"
require "../forms/transaction"

get "/" do
  expenses = Repositories::Transaction.this_month.order(:date)
  form = UI::Forms::Transaction.build(::Forms::Transaction.empty)
  render "src/templates/home.ecr", "src/templates/layouts/application.ecr"
end
