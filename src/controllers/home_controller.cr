require "kemal"
require "money"
require "../repositories/expense"

get "/" do
  expenses = Repositories::Expense.this_month.order(:date)
  render "src/templates/home.ecr", "src/templates/layouts/application.ecr"
end
