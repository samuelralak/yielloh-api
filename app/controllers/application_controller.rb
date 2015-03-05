class ApplicationController < ActionController::API
	before_filter :verify_subdomain
	before_filter :require_profile
	include ActionController::Serialization
	include ActionController::HttpAuthentication::Basic::ControllerMethods
	include ActionController::MimeResponds
	include ActionController::ImplicitRender
	include ActionController::Rescue
	include ActionView::Layouts

	respond_to :json, :html, :xml

	def current_user
		User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token	
	end

	helper_method :current_user

	private
		def verify_subdomain
			unless request.subdomain.start_with?('api') || request.subdomain.start_with?('staging')
				puts "######## SUBDOMAIN: #{request.subdomain}"	
				raise ActionController::RoutingError, "Route not found"
			end
		end

		def require_profile
			if current_user && current_user.profile.nil?
				render json: { message: "No profile found" }, status: :forbidden
			end
		end
end