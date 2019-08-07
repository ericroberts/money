require "kemal"
require "dotenv"
require "./src/controllers/expenses_controller"
require "./src/controllers/home_controller"
require "./src/controllers/plaid_controller"
require "./src/controllers/transactions_controller"

Dotenv.load
Kemal.run
