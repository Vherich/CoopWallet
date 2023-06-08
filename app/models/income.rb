class Income < ApplicationRecord
  belongs_to :user
  belongs_to :group
  CATEGORY = ["Salário", "Outros"]
end
