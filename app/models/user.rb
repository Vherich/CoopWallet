class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :outcomes
  has_many :incomes
  has_one :membership
  has_one :group, through: :membership, foreign_key: "group_id"
end
