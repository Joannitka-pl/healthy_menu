class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google]

  validates :nick, presence: true

  def self.from_omniauth(access_token)
    data = access_token.info
    email = data['email']
    user = User.find_by(email: email)
    unless user
      password = Devise.friendly_token[0, 20]
      user = User.create(nick: data['name'], email: email, password: password,
                         password_confirmation: password, provider: access_token.provider)
    end
    user
  end

  has_many :dishes, dependent: :destroy
end
