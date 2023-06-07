require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
10.times do
  User.create(name: Faker::Name.name, email: Faker::Internet.email, password: '123456')
end

users = User.all

5.times do
  Group.create(group_name: Faker::Lorem.word,
               users: [users.sample(3)].flatten)
end

groups = Group.all

users.each do |user|
  rand(5..10).times do
    Income.create(date: Faker::Date.between(from: '2020-01-01', to: '2020-12-31'),
                  income_category: Faker::Commerce.department,
                  value: Faker::Commerce.price(range: (100..2000)),
                  description: Faker::Commerce.product_name,
                  user:,
                  group: [groups.sample, nil].sample)
  end
  rand(5..10).times do
    Outcome.create(date: Faker::Date.between(from: '2020-01-01', to: '2020-12-31'),
                   outcome_category: Faker::Commerce.department,
                   value: Faker::Commerce.price(range: (50..1000)),
                   description: Faker::Commerce.product_name,
                   payment_form: ["Cash", "Credit card", "Bank transfer", "Paypal"].sample,
                   user:,
                   group: [groups.sample, nil].sample)
  end
end
