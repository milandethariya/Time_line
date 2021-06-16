class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true,length: {maximum: 140}
  mount_uploader :micropost_image, ProfileImageUploader
  validate :micropost_size

  def micropost_size
    if micropost_image.size > 1.megabytes
      errors.add(:picture, "micropost_image should be less than 2MB")
    end
  end

  def is_like?(user)
    users.include?(user)
  end
end
