class RegistrationsController < Devise::RegistrationsController
	protected
		def sign_up_params
			#devise_parameter_sanitizer.sanitize(:sign_up)
			params.require(:user).permit(
				:email, :password, :password_confirmation, profile_attributes: [
					:id, :gender_id, :date_of_birth
				]
			)
    
  		end
end