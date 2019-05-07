class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:nick, :email, :password,
                                 :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:nick, :email, :password,
                                 :password_confirmation, :current_password)
  end

  def update_resource(resource, params)
    if resource.provider == 'google'
      params.delete('current_password')
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end
end
