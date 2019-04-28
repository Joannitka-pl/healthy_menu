require 'rails_helper'

feature 'User management' do
  before :each do
    visit root_path
  end

  let(:user) { create(:user) }

  scenario 'adds a new user' do
    expect {
      click_link 'Sign up'
      fill_in 'Nick', with: 'tester'
      fill_in 'Email', with: 'test@mail.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_button 'Sign up'
    }.to change(User, :count).by(1)
    expect(current_path).to eq root_path
    expect(page).to have_content 'tester'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'logs in using google oauth2' do
      stub_omniauth
      click_link 'Sign up'
      expect(page).to have_link 'Sign in with Google'
      click_link "Sign in with Google"
      expect(page).to have_content 'Successfully authenticated from Google account.'
      expect(page).to have_link 'Log out'
  end

  scenario 'logs in an existing user' do
    login user
    expect(current_path).to eq root_path
    expect(page).to have_content 'tester'
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'logs out an logged user' do
    login user
    click_link 'Log out'
    expect(current_path).to eq root_path
    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'deletes user' do
    login user
    expect { click_link 'Delete account' }.to change(User, :count).by(-1)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Bye! Your account has been successfully cancelled. We hope to see you again soon.'
  end

  scenario 'remembers user for 2 weeks if remember me is checked' do
    login_with_remember_me user
    expire_cookies

    Timecop.freeze(Date.today + 14) do
      visit '/'
      expect(page).to have_link 'Log out'
    end
  end

  scenario 'forgets user after close browser if remember me is not checked' do
    login user
    expire_cookies
    visit '/'
    expect(page).to have_link 'Login'
  end

  scenario 'forgets user after 2 weeks' do
    login_with_remember_me user
    expire_cookies

    Timecop.freeze(Date.today + 15) do
      visit '/'
      expect(page).to have_link 'Login'
    end
  end
end
