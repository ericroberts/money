require "kemal"
require "money"
require "../builders/transaction"
require "../repositories/transaction"
require "../inputs/date"
require "../inputs/money"
require "../inputs/text"
require "../forms/transaction"

get "/" do
  expenses = Repositories::Transaction.this_month.order(:date)
  errors = Builders::Errors.new
  builder = Builders::Transaction.empty
  transaction_form = Forms::Transaction.new(builder)
  render "src/templates/home.ecr", "src/templates/layouts/application.ecr"
end
