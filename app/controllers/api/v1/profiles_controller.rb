class Api::V1::ProfilesController < ApplicationController
  before_action      :doorkeeper_authorize!, except: [:show]
  before_action      :process_cover_photo,   only:   [:update]
  before_action      :process_avatar,        only:   [:update]
  before_action      :set_profile,           only:   [:show]

  def me
    render json: current_user, root: false, status: :ok
  end

  def show
    @profile = Profile.find(params[:id])

    render json: @profile, root: false, status: :ok
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
      @profile = current_user.profile

      if @profile.update(profile_params)
          render json: @profile, root: false, status: :ok, location: @api_profile
      else
          render json: @profile.errors, status: :unprocessable_entity
      end
  end

  def add_interests
      @user = current_user
      new_interests = params[:interests].map(&:inspect).join(', ')
      logger.info "############ NEW INTERESTS: #{new_interests}"
      @user.interest_list = new_interests

      if @user.save
          render json: current_user, status: :ok
      end
  end

  def remove_interests
      @user = current_user
      removed_interests = params[:interests].map(&:inspect).join(', ')
      logger.info "############ REMOVED INTERESTS: #{removed_interests}"
      @user.interest_list.remove(removed_interests)

      render json: current_user, status: :ok
  end

  private
    def set_profile
      @profile = current_user
    end

    def profile_params
      params.require(:profile).permit(:fullname, :username, :tagline, :location, :user_id, 
        :twitter_handle, :facebook_handle, :gender, :avatar, :cover_photo)
    end

    def process_image(attribute)
      if params[:profile] && params[:profile]["#{attribute.to_sym}"]
        data = StringIO.new(Base64.decode64(params[:profile]["#{attribute.to_sym}"][:data]))
        data.class.class_eval { attr_accessor :original_filename, :content_type }
        data.original_filename = params[:profile]["#{attribute.to_sym}"][:filename]
        data.content_type = params[:profile]["#{attribute.to_sym}"][:content_type]
        params[:profile]["#{attribute.to_sym}"] = data
      end
    end

    def process_avatar
      process_image("avatar")
    end

    def process_cover_photo
      process_image("cover_photo")
    end
end
