class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  validates :user_id, uniqueness: { scope: :group_id }
end
