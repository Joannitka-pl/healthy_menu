FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com"}
    sequence(:nick) { |n| "tester#{n}"}
    password '123456'
  end
end
