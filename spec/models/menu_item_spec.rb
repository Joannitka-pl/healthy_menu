require 'rails_helper'

describe MenuItem do
  it 'has a valid factory' do
    expect(build(:menu_item)).to be_valid
  end

  it 'is invalid without the user' do
    menu_item = build(:menu_item, user_id: nil)
    menu_item.valid?
    expect(menu_item.errors[:user]).to include('must exist')
  end

  it 'is invalid without the dish' do
    menu_item = build(:menu_item, dish: nil)
    menu_item.valid?
    expect(menu_item.errors[:dish]).to include('must exist')
  end

  it 'is invalid without the day' do
    menu_item = build(:menu_item, day: nil)
    menu_item.valid?
    expect(menu_item.errors[:day]).to include("can't be blank")
  end

  it 'is invalid without the meal' do
    menu_item = build(:menu_item, meal: nil)
    menu_item.valid?
    expect(menu_item.errors[:meal]).to include("can't be blank")
  end
end
