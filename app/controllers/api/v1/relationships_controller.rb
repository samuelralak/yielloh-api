class Api::V1::RelationshipsController < ApplicationController
	before_action :doorkeeper_authorize!

	def create
		@user = User.find(params[:relationship][:followed_id])

		unless current_user.following?(@user)
			current_user.follow!(@user)
			render json: @user, root: false, status: :created
		else
			render json: {error: "you are already following this user"}, status: :unprocessable_entity
		end
	end

	def destroy
		@user = User.find(params[:id])
		current_user.unfollow!(@user)
		
		render json: @user, root: false, status: :ok
	end

	def following
    	@user = User.find(params[:id])

    	render json: @user.followed_users, root: false, status: :ok
  	end

  	def followers
    	@user = User.find(params[:id])
    	
    	render json: @user.followers, root: false, status: :ok
  	end
end
