class Api::V1::UserSessionsController < ApplicationController
	before_action :doorkeeper_authorize!

	def destroy
		Doorkeeper::AccessToken.revoke_all_for(doorkeeper_token.application_id, current_user)
		env['warden'].logout
		render json: "OK", status: 200
	end
end
