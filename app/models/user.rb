class User < ApplicationRecord
	validates :name, presence: true
	validates :email, :presence => true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :telephone, :presence => true,
                 numericality: { only_integer: true },
                 :length => { :minimum => 10, :maximum => 15 } 

	has_many :reservations
	has_many :rooms, through: :reservations
	has_secure_password

	def self.by_user(user_id)
		self.where(id: user_id)
	end

end


