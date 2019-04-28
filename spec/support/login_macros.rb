module LoginMacros
  def login(user)
    visit('/users/sign_in')
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_button('Log in')
  end

  def login_with_remember_me(user)
    visit('/users/sign_in')
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    check 'Remember me'
    click_button('Log in')
  end

  def stub_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
      provider: "google",
      uid: "12345678910",
      info: {
        email: ENV["GMAIL"]
      },
      credentials: {
        token: "abcdefg12345",
        refresh_token: "12345abcdefg",
        expires_at: DateTime.now,
      }
    })
end

end
