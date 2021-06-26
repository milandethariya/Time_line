class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true,length: {maximum: 140}
  mount_uploader :micropost_image, ProfileImageUploader
  validate :micropost_size

  def micropost_size
    if micropost_image.size > 2.megabytes
      errors.add(:picture, "micropost_image should be less than 2MB")
    end
  end

  def find_user(user)
    self.user == user
  end

  def like_count
    self.likes.where(is_like: true).count
  end

  def unlike_count
    self.likes.where(is_like: false).count
  end

  def is_like(user)
    self.likes.where(user_id: user.id, is_like: true).count == 1 
  end

  def is_unlike(user)
    self.likes.where(user_id: user.id, is_like: false).count == 1 
  end
end
