class Friendship < ApplicationRecord
	belongs_to :receiver, class_name: "User"
	belongs_to :sender, class_name: "User"

	def self.find_request(user1,user2)
		Friendship.find_by(sender_id: [user1.id,user2.id], receiver_id: [user1.id,user2.id])
	end
end
