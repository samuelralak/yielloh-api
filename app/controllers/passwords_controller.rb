class PasswordsController < Devise::RegistrationsController

	def create
		self.resource = resource_class.send_reset_password_instructions(resource_params)
		yield resource if block_given?

		if successfully_sent?(resource)
			render json: { message: "password reset token successfully sent" }, status: :created
		else
			render json: { error: "email not found"}, status: :unprocessable_entity
		end
	end
end
