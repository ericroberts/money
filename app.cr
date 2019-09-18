require "kemal"
require "dotenv"
require "./src/controllers/home_controller"
require "./src/controllers/transactions_controller"

Dotenv.load
Kemal.run
