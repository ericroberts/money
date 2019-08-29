require "kemal"
require "money"
require "../builders/transaction"
require "../repositories/transaction"
require "../ui/forms/transaction"
require "../forms/transaction"

get "/" do
  expenses = Repositories::Transaction.this_month.order(:date)
  builder = Builders::Transaction.empty
  transaction_form = UI::Forms::Transaction.build(builder)
  new_form = UI::Forms::NewTransaction.build(::Forms::Transaction.empty)
  render "src/templates/home.ecr", "src/templates/layouts/application.ecr"
end
