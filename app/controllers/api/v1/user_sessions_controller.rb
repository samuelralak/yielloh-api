class Api::V1::UserSessionsController < ApplicationController
	before_action :doorkeeper_authorize!
	skip_before_action :require_profile

	def destroy
		Doorkeeper::AccessToken.revoke_all_for(doorkeeper_token.application_id, current_user)
		sign_out current_user
		render json: "OK", status: 200
	end
end
