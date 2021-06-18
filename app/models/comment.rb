class Comment < ApplicationRecord
  belongs_to :micropost
  belongs_to :user
  validates :micropost_id, presence: true
  validates :user_id, presence: true
  validates :comment, presence: true
  default_scope -> { order(created_at: :desc) }
end
