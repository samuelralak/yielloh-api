require "application_responder"

class ErrorsController < ActionController::API
	elf.responder = ApplicationResponder
	respond_to :html, :xml, :json

	# include ActionController::MimeResponds
	include ActionController::ImplicitRender
	rescue_from ActionController::RoutingError, with: :url_not_identified

	def url_not_identified
		render json: "{\"error\" : \"route_not_found\"}", status: :not_found
	end
end
