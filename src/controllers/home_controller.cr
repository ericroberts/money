require "kemal"
require "money"
require "../repositories/transaction"

get "/" do
  expenses = Repositories::Transaction.this_month.order(:date)
  render "src/templates/home.ecr", "src/templates/layouts/application.ecr"
end
