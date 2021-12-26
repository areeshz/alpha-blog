class Article < ApplicationRecord
	validates :title, presence: true, length: {minimum: 6, maximum: 100}
	validates :description, presence: true, length: {minimum: 10, maximum: 300}

	# ":user" must be singular for this to work, not ":users"
	# in rails 5 and onwards, having a 'belongs_to' association
	# automatically makes that reference required.
	# So an article must have a user.
	# It can be made optional with "belongs_to :user, optional: true"
	belongs_to :user

	has_many :article_categories
	has_many :categories, through: :article_categories
end