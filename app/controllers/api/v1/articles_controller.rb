class Api::V1::ArticlesController < ApplicationController
	before_action :doorkeeper_authorize!, except: [:index, :show]
	before_action :process_media, 		  only:   [:create, :update]
	before_action :set_article, 		  only:   [:show, :update, :destroy]
	
	def index
		@articles = Article.all

		render json: @articles, status: :ok
	end

	def show
		render json: @article, status: :ok
	end

	def create
		@article = Article.new(article_params)
		
		if @article.save
			post = @article.post
			tags = article_params[:tags].map(&:inspect).join(', ')
      		post.tag_list = tags
      		post.save!

			render json: @article, status: :created
		else
			render json: @article.errors, status: :unprocessable_entity
		end
	end

	def update
		if @article.update(article_params)
			render json: @article, status: :ok
		else
			render json: @article.errors, status: :unprocessable_entity
		end
	end

	def my_articles
		@articles = current_user.posts.where(postable_type: 'Article')

		render json: @articles, status: :ok
	end

	def destroy
		@article.destroy

		head :no_content
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
