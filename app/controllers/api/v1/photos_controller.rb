class Api::V1::PhotosController < ApplicationController
	before_action :doorkeeper_authorize!, except: [:index, :show]
	before_action :process_media, 		  only:   [:create, :update]
	before_action :set_photo, 		  only:   [:show, :update, :destroy]
	
	def index
		@photos = Photo.all

		render json: @photos, status: :ok
	end

	def show
		render json: @photo, status: :ok
	end

	def create
		@photo = Photo.new(photo_params)
		
		if @photo.save
			render json: @photo, status: :created
		else
			render json: @photo.errors, status: :unprocessable_entity
		end
	end

	def update
		if @photo.update(photo_params)
			render json: @photo, status: :ok
		else
			render json: @photo.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@photo.destroy

		head :no_content
	end

	private
		def set_photo
			@photo = photo.find(params[:id])
		end

		def photo_params
			params.require(:photo).permit(
				:image, :caption, post_attributes: [:id, :postable_id, :postable_type, :user_id]
			)
		end

		def process_media
            if params[:photo] && params[:photo][:image]
                data = StringIO.new(Base64.decode64(params[:photo][:image][:data]))
                data.class.class_eval { attr_accessor :original_filename, :content_type }
                data.original_filename = params[:photo][:image][:filename]
                data.content_type = params[:photo][:image][:content_type]
                params[:photo][:image] = data
            end
        end
end
