class MenuItem < ApplicationRecord
  belongs_to :user
  belongs_to :dish
  validates :day, :meal, presence: true

  DAYS = %w[monday tuesday wednesday thursday friday saturday sunday].freeze
  MEALS = %w[breakfast brunch lunch snack dinner supper].freeze
end
