class Group < ApplicationRecord
  has_many :outcomes
  has_many :incomes
  has_many :memberships
  has_many :users, through: :memberships
end
