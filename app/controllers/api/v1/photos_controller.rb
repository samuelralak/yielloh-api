class Api::V1::PhotosController < ApplicationController
	before_action :doorkeeper_authorize!, except: [:index, :show]
	before_action :set_photo, only:   [:show, :update, :destroy]
	skip_before_action :require_profile,  only:   [:index, :show]

	def create
		photos = Array.new
		errors = Array.new

		params[:_json].each do |photo_attributes|
			photo_params = ActionController::Parameters.new(photo_attributes)
			permitted_photo_params = photo_params.require(:photo).permit(
				:image, :caption, post_attributes: [:id, :postable_id, :postable_type, :user_id]
			)

			begin
				photos << Photo.create!(permitted_photo_params)
			rescue ActiveRecord::RecordInvalid => e
				photos << e.record
				errors << e.to_s
			end
		end

		respond_to do |format|
			if photos.all?(&:persisted?)
				format.json { render json: photos, root: false, status: :created }
			else
				format.json { render json: { message: errors }, status: :unprocessable_entity }
			end
		end
	end

	private
		def set_photo
			@photo = photo.find(params[:id])
		end
end
