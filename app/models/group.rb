class Group < ApplicationRecord
  has_many :outcomes
  has_many :incomes
  has_many :user, through: :memberships
end
