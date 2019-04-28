class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google]

  def self.from_omniauth(access_token)
    data = access_token.info
    email = data['email']
    user = User.find_by(email: email)

    unless user
      password = Devise.friendly_token[0, 20]
      user = User.create(nick: data['nick'], email: email, password: password,
                         password_confirmation: password)
    end
    user
  end
end
