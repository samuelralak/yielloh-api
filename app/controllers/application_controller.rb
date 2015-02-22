class ApplicationController < ActionController::API
	include ActionController::HttpAuthentication::Basic::ControllerMethods
	include ActionController::MimeResponds
	include ActionController::ImplicitRender
	include ActionController::Rescue
	include ActionView::Layouts

	respond_to :html, :json, :xml

	def current_user
		User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token	
	end

	helper_method :current_user
end
