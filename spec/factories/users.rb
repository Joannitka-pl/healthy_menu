FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com"}
    nick 'tester'
    password '123456'
  end
end
