class User < ApplicationRecord
	has_many :microposts, dependent: :destroy
	validates :name, presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }
	before_save {self.email = email.downcase }
	validates :birthdate, presence: true
	validates :gender, presence: true
	has_secure_password
	validates :password,  presence: true, length: { minimum: 6 },allow_nil: true
	mount_uploader :profile_image, ProfileImageUploader
	mount_uploader :cover_image, ProfileImageUploader
	validate :profile_size
	validate :cover_size

	def profile_size
    if profile_image.size > 5.megabytes
      errors.add(:picture, "profile_image should be less than 2MB")
    end
  end

  def cover_size
  	if cover_image.size > 2.megabytes
  		errors.add(:picture, "cover_image should be less than 2MB")
		end
	end

end
