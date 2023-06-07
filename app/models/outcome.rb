class Outcome < ApplicationRecord
  belongs_to :user
  belongs_to :group
  CATEGORY = ["Alimentação", "Educação", "Lazer", "Moradia", "Saúde", "Transporte", "Vestuário", "Outros"]
  validates :date, :outcome_category, :value, :description, :payment_form, presence: true
end
