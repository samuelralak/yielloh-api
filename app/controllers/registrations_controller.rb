class RegistrationsController < Devise::RegistrationsController
	before_action :doorkeeper_authorize!, only: [:update]
	prepend_before_action :authenticate_scope!, only: [:edit, :destroy]

	protected
		def sign_up_params
			#devise_parameter_sanitizer.sanitize(:sign_up)
			params.require(:user).permit(
				:email, :password, :password_confirmation, profile_attributes: [
					:id, :gender, :date_of_birth, :username, :fullname
				]
			)
    
  		end
end
