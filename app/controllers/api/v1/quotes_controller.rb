class Api::V1::QuotesController < ApplicationController
	before_action :doorkeeper_authorize!, except: [:index, :show]
	skip_before_action :require_profile,  only:   [:index, :show]
	before_action :set_quote, 			  only:   [:show, :update, :destroy]
	
	def index
		@quotes = Quote.all

		respond_to do |format|
			format.json { render json: @quotes, root: false, status: :ok, location: @api_quotes }
		end
	end

	def show
		respond_to do |format|
			format.json { render json: @quote, root: false, status: :ok, location: @api_quote }
		end
	end

	def create
		@quote = Quote.new(quote_params)

		respond_to do |format|
			if @quote.save
				format.json { render json: @quote, root: false, status: :created, location: @api_quote }
			else
				format.json { render json: @quote.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @quote.update(quote_params)
				format.json { render json: @quote, root: false, status: :ok, location: @api_quote }
			else
				format.json { render json: @quote.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@quote.destroy

		respond_to do |format|
			format.json { head :no_content }
		end
	end

	private
		def set_quote
			@quote = Quote.find(params[:id])
		end

		def quote_params
			params.require(:quote).permit(:content, post_attributes: [:id, :postable_id, :postable_type, :user_id])
		end
end
