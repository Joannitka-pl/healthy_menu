require 'rails_helper'

describe User do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid without an email' do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email' do
    user = build(:user, email: create(:user).email)
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end

  it 'is invalid with an email with wrong format' do
    user = build(:user, email: 'test')
    user.valid?
    expect(user.errors[:email]).to include('is invalid')
  end

  it 'is invalid without a password' do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it 'is invalid with a password of less than 6' do
    user = build(:user, password: '123')
    user.valid?
    expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
  end

  it 'is invalid without a nick' do
    user = build(:user, nick: nil)
    user.valid?
    expect(user.errors[:nick]).to include("can't be blank")
  end
end
