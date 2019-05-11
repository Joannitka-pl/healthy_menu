FactoryGirl.define do
  factory :menu_item do
    user
    dish
    day 'monday'
    meal 'lunch'
  end
end
