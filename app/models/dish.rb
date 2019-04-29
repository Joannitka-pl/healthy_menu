class Dish < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: true

  scope :private_dishes, -> { where(public: false) }
  scope :public_dishes, -> { where(public: true) }
  scope :own_dishes, ->(user) { where(user_id: user.id) }
  scope :public_or_own_dishes, ->(user) { public_dishes.or(own_dishes(user)) }
end
