class User < ApplicationRecord
	# This can alternatively be done in a "do" block, if there's more to be done and need several lines
	before_save { self.email = email.downcase }

	validates :username, presence: true,
		uniqueness: { case_sensitive: false },
		length: {minimum: 3, maximum: 25}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true,
		uniqueness: { case_sensitive: false },
		length: {maximum: 105}, format: {with: VALID_EMAIL_REGEX}

	has_many :articles
end