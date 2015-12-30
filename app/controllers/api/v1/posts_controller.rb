class Api::V1::PostsController < ApplicationController
	before_action      :doorkeeper_authorize!, except: [:all, :show]
	skip_before_action :require_profile,       only:   [:all, :show]
	before_action      :load_postable, 		   except: [:all]

	def all
		if params[:tag]
			@posts = Post.tagged_with(params[:tag]).order('created_at DESC')
		else
			@posts = Post.all.order('created_at DESC')
		end

		render json: @posts, status: :ok
	end

	def show
		@post = @postable.post

		render json: @post, root: false, status: :ok
	end

	def create
		@post = @postable.posts.new(params[:post])

		if @post.save
			render json: @post, status: :created
		else
				
		end
			
	end

	def destroy
		@postable.destroy

		head :no_content
	end

	private
		def load_postable
			klass = [Quote, Article].detect { |c| params["#{c.name.underscore}_id"] }
			@postable = klass.find(params["#{klass.name.underscore}_id"])
		end
end
