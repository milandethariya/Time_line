class Like < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  default_scope -> { order(updated_at: :desc) }


end
