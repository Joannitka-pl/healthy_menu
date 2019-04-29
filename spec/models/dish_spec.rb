require 'rails_helper'

describe Dish do
  it 'has a valid factory' do
    expect(build(:dish)).to be_valid
  end

  it 'is invalid without the name' do
    dish = build(:dish, name: nil)
    dish.valid?
    expect(dish.errors[:name]).to include("can't be blank")
  end

  it 'is invalid with a duplicate name' do
    create(:dish, name: 'test_dish')
    dish = build(:dish, name: 'test_dish')
    dish.valid?
    expect(dish.errors[:name]).to include('has already been taken')
  end

  it 'is invalid without the user' do
    dish = build(:dish, user_id: nil)
    dish.valid?
    expect(dish.errors[:user]).to include('must exist')
  end
end
