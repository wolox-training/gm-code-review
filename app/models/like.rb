class Like < ApplicationRecord
  validates :post_id, uniqueness: { scope: %i[user_id] }

  belongs_to :user, optional: false
  belongs_to :post, optional: false
end
