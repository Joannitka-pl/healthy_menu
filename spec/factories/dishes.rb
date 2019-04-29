FactoryGirl.define do
  factory :dish do
    user
    sequence(:name) { |n| "test#{n}_dish"}
  end
end
