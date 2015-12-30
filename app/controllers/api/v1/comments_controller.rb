class Api::V1::CommentsController < ApplicationController
	before_action :doorkeeper_authorize!
	before_action :set_comment, only: [:update, :destroy]

	def index
		@comments = Comment.where(commentable_id: params[:commentable_id]).order('created_at DESC')	

		render json: @comments, status: :ok
	end

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.new(comment_params)

		if @comment.save
			render json: @comment, root: false, status: :created
		else
			render json: @comment.errors, status: :unprocessable_entity
		end
	end

	def update
		respond_to do |format|
			if @comment.update(comment_params)
				format.json { render json: @comment, root: false, status: :ok }
			else
				format.json { render json: @comment.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@comment.destroy

		respond_to do |format|
			format.json { head :no_content }
		end
	end

	private
		def set_comment
			@comment = Comment.find(params[:id])	
		end

		def comment_params
			params.require(:comment).permit(:title, :comment, :commentable_id, :commentable_type, :user_id)
		end
end
