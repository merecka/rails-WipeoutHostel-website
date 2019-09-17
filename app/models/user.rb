class User < ApplicationRecord
	has_many :reservations
	has_many :rooms, through: :reservations
	has_secure_password

	def self.by_user(user_id)
		self.where(id: user_id)
	end

end