require "kemal"
require "../repositories/transaction"
require "../forms/transaction"

get "/" do
  expenses = Repositories::Transaction.this_month.order(:date)
  ui_form = ::Forms::Transaction.empty.to_ui_form
  render "src/templates/home.ecr", "src/templates/layouts/application.ecr"
end
