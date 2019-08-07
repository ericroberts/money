require "kemal"

get "/plaid" do
  render(
    "src/templates/plaid/index.ecr",
    "src/templates/layouts/application.ecr",
  )
end
