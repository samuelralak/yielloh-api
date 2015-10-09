class Api::V1::QuotesController < ApplicationController
	before_action :doorkeeper_authorize!, except: [:index, :show]
	skip_before_action :require_profile,  only:   [:index, :show]
	before_action :set_quote, 			  only:   [:show, :update, :destroy]
	
	def index
		@quotes = Quote.all

		render json: @quotes, status: :ok
	end

	def show
		render json: @quote, status: :ok
	end

	def create
		@quote = Quote.new(quote_params)

		
		if @quote.save
			post = @quote.post
			tags = quote_params[:tags].map(&:inspect).join(', ')
      		post.tag_list = tags
      		post.save!

			render json: @quote, status: :created
		else
			render json: @quote.errors, status: :unprocessable_entity
		end
	end

	def update
		if @quote.update(quote_params)
			render json: @quote, status: :ok
		else
			render json: @quote.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@quote.destroy

		head :no_content
	end

	private
		def set_quote
			@quote = Quote.find(params[:id])
		end

		def quote_params
			if params[:quote][:tags]
				params.require(:quote).permit(:content, :tags, post_attributes: [
					:id, :postable_id, :postable_type, :user_id, :page_id, :tags]).merge(tags: params[:quote][:tags])
			else
				params.require(:quote).permit(:content, post_attributes: [:id, :postable_id, :postable_type, :user_id])
			end
		end
end
