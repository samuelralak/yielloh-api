require "application_responder"

class ApplicationController < ActionController::API
  	self.responder = ApplicationResponder
  	respond_to :html, :xml, :json

	before_filter :verify_subdomain
	before_filter :require_profile
	include ActionController::Serialization
	include ActionController::HttpAuthentication::Basic::ControllerMethods
	# include ActionController::MimeResponds
	include ActionController::ImplicitRender
	include ActionController::Rescue
	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

	def default_serializer_options
		{ root: false }
	end

	# this is to customise the OAuth invalid token response we get
	# https://github.com/applicake/doorkeeper/wiki/Customizing-the-response-body-when-unauthorized
	def doorkeeper_unauthorized_render_options
		{ json: { error: "invalid_token"} }
	end

	respond_to :json

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

		def record_not_found
			render json: "{\"error\" : \"record_not_found\"}", status: :not_found
		end
end
