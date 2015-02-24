class ProfilesController < ApplicationController
  before_action :doorkeeper_authorize!, except: [:show]
  before_action :set_profile, only: [:show, :edit, :update]

  def index
    @profiles = Profile.all
    respond_with(@profiles)
  end

  def show
    respond_with(@profile)
  end

  def create
    @profile = current_user.build_profile(profile_params)
    @profile.save
    respond_with(@profile)
  end

  def update
    @profile.update(profile_params)
    respond_with(@profile)
  end

  private
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:fullname, :username, :about, :location, :user_id)
    end
end
