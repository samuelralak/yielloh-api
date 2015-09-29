class Api::V1::ArticlesController < ApplicationController
	before_action :doorkeeper_authorize!, except: [:index, :show]
	before_action :process_media, 		  only:   [:create, :updatearticle]
	before_action :set_article, 		  only:   [:show, :update, :destroy]
	
	def index
		@articles = Article.all

		respond_to do |format|
			format.json { render json: @articles, root: false, status: :ok, location: @api_articles }
		end
	end

	def show
		respond_to do |format|
			format.json { render json: @article, root: false, status: :ok, location: @api_article }
		end
	end

	def create
		@article = Article.new(article_params)
		logger.info "############ ARTICLE_PARAMS: #{article_params.inspect}"
		
		if @article.save
			post = @article.post
			tags = article_params[:tags].map(&:inspect).join(', ')
      		logger.info "############ TAGS: #{tags}"
      		post.tag_list = tags
      		post.save!

			render json: @article, status: :created
		else
			render json: @article.errors, status: :unprocessable_entity
		end
	end

	def update
		respond_to do |format|
			if @article.update(article_params)
				format.json { render json: @article, root: false, status: :ok, location: @api_article }
			else
				format.json { render json: @article.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@article.destroy

		respond_to do |format|
			format.json { head :no_content }
		end
	end

	private
		def set_article
			@article = Article.find(params[:id])
		end

		def article_params
			if params[:article][:tags]
				params.require(:article).permit(:title, :media, :content, :tags, 
					post_attributes: [:id, :postable_id, :postable_type, :user_id, :page_id, :tags]).merge(tags: params[:article][:tags])
			end
		end

		def process_media
            if params[:article] && params[:article][:media]
                data = StringIO.new(Base64.decode64(params[:article][:media][:data]))
                data.class.class_eval { attr_accessor :original_filename, :content_type }
                data.original_filename = params[:article][:media][:filename]
                data.content_type = params[:article][:media][:content_type]
                params[:article][:media] = data
            end
        end
end
