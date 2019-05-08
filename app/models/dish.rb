class Dish < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: true

  scope :personal, -> { where(public: false) }
  scope :published, -> { where(public: true) }
  scope :own, ->(user) { where(user_id: user.id) }
  scope :published_or_own, ->(user) { published.or(own(user)) }
end
