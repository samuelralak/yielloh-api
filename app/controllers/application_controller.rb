class ApplicationController < ActionController::API
	include ActionController::HttpAuthentication::Basic::ControllerMethods
	include ActionController::MimeResponds
	include ActionController::ImplicitRender
	include ActionController::RequestForgeryProtection
	include ActionController::Rescue
	include ActionView::Layouts
end
