# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create(name: "João", email: "joao@example.com", password: "123456")
Group.create(group_name: "Amigos")
Income.create(date: Date.today, income_category: "Salário", value: 1000.00, description: "Meu salário",
              user: User.first, group: Group.first)
Outcome.create(date: Date.today, outcome_category: "Aluguel", value: 500.00, description: "Pagamento do aluguel do mês",
               payment_form: "Boleto", user: User.first, group: Group.first)
Membership.create(user: User.first, group: Group.first, accepted: true)
