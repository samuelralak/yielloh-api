class Api::V1::PostsController < ApplicationController
	before_action      :doorkeeper_authorize!, except: [:all, :show]
	skip_before_action :require_profile,       only:   [:all, :show]
	before_action      :load_postable, 		   except: [:all]

	def all
		@posts = Post.all

		respond_to do |format|
			format.json { render json: @posts, root: false, status: :ok }
		end
	end

	def show
		@post = @postable.post

		respond_to do |format|
			format.json { render json: @post, root: false, status: :ok }
		end
	end

	def create
		@post = @postable.posts.new(params[:post])

		respond_to do |format|
			if @post.save
				format.json { render json: @post, root: false, status: :created, location: @api_post}
			else
				
			end
		end
			
	end

	def destroy
		@postable.destroy

		respond_to do |format|
			format.json { head :no_content }
		end
	end

	private
		def load_postable
			klass = [Quote, Article].detect { |c| params["#{c.name.underscore}_id"] }
			@postable = klass.find(params["#{klass.name.underscore}_id"])
		end
end
