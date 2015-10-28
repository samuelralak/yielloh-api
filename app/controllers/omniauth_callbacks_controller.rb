class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def all
		#raise request.env["omniauth.auth"].to_yaml
		 @user = User.from_omniauth(request.env["omniauth.auth"])
		 if @user.persisted?
		 	#if omniauth succesfull signin/signup user 
         	#flash.notice = "Signed In!"
         	sign_in_and_redirect @user
         else
         	session["devise.user_attributes"] = @user.attributes
         	#redirect to registration
         	redirect_to "user/sign_up"
         end
         		
	end

	#use one method for all callbacks
	alias_method :facebook, :all
	alias_method :twitter, :all
end
