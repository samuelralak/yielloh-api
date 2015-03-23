class ErrorsController < ActionController::API
	include ActionController::MimeResponds
	include ActionController::ImplicitRender
	rescue_from ActionController::RoutingError, with: :url_not_identified

	def url_not_identified
		render json: "{\"error\" : \"route_not_found\"}", status: :not_found
	end
end
