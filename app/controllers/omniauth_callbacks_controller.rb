class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google
    req = request.env['omniauth.auth']
    @user = User.from_omniauth(req)
    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = req
      redirect_to new_user_registration_url
    end
  end
end
