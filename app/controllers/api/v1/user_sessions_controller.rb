class Api::V1::UserSessionsController < ApplicationController
	before_action :doorkeeper_authorize!
	skip_before_action :require_profile

	def logout_user
		Doorkeeper::AccessToken.revoke_all_for(doorkeeper_token.application_id, current_user)
		current_user.update_attributes(current_sign_in_at: nil, current_sign_in_ip: nil)
		render json: { message: "you have successfully logged out"}, status: 200
	end
end
