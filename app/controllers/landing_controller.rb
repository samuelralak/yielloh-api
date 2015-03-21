class LandingController < ApplicationController
	include ActionController::RequestForgeryProtection
	skip_before_action :doorkeeper_authorize!

	def index
		puts "################### USER ID: #{current_user.inspect}"
	end

	def login
		params[:user] = {:email => params[:user][:email], :password => params[:user][:password]}
      	allow_params_authentication!
      	if current_user
      		redirect_to oauth_applications_path(user: current_user.id)	
      	else
      		redirect_to root_path
      	end
      	
		# user = User.find_by_email(params[:user][:email])
		# puts "################### FOUND USER: #{user.inspect}"
		# if user.valid_password?params[:user][:password]
			# puts "################### LOGGED IN USER: #{user.inspect}"
			# cookies.signed['user_id'] = user.id
			# puts "################### LOGGED IN USER IN COOKIES: #{cookies.signed[:user_id]}"
			# request.headers['USER_ID'] = 'SOME VALUE'
			# sign_in_and_redirect user
		# else
			# redirect_to root_path
		# end
	end

	def logout
		
	end
end
