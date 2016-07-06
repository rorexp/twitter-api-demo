class RegistrationsController < Devise::RegistrationsController
  private
    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation,
        :access_token, :access_token_secret)
    end
end
