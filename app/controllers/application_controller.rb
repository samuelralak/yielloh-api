class ApplicationController < ActionController::API
	before_filter :verify_subdomain
	before_filter :require_profile
	include ActionController::Serialization
	include ActionController::HttpAuthentication::Basic::ControllerMethods
	include ActionController::MimeResponds
	include ActionController::ImplicitRender
	include ActionController::Rescue
	include ActionController::Cookies
	include ActionController::Flash
	include ActionView::Layouts
	include ActionView::Helpers

	respond_to :json, :html, :xml

	def current_user
		if doorkeeper_token
			current_resource_owner
		else
			# fallback to auth with warden if no doorkeeper token
			if session[:user]
				User.find(session[:user])
			else
				warden.authenticate(:scope => :user)
			end
		end
	end

	# Needed for doorkeeper find the user that owns the access token
	def current_resource_owner
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

		def after_sign_in_path_for(resource_or_scope)
			if resource_or_scope.is_a?(User) && resource_or_scope.has_role?(:super_admin)
				oauth_applications_path
			else
				super
			end
		end
end