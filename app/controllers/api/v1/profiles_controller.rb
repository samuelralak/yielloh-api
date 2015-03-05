class Api::V1::ProfilesController < ApplicationController
  before_action      :doorkeeper_authorize!, except: [:show]
  skip_before_action :require_profile,       only:   [:create, :show]
  before_action      :set_profile,           only:   [:show, :update]

  def show
   respond_to do |format|
      format.json { render json: @profile, root: false, status: :ok}
    end
  end

  def create
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      respond_to do |format|
        format.json { render json: @profile, root: false, status: :created, location: @api_profile}
      end
    else
      respond_to do |format|
        format.json { render json: @profile.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.json { render json: @profile, root: false, status: :ok, location: @api_profile }
      else
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:fullname, :username, :about, :location, :user_id)
    end
end
