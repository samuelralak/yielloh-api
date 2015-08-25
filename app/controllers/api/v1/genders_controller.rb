class Api::V1::GendersController < ApplicationController
  before_action :set_gender, only: [:show, :update, :destroy]

  # GET /genders
  # GET /genders.json
  def index
    @genders = Gender.all

    render json: @genders
  end

  # GET /genders/1
  # GET /genders/1.json
  def show
    render json: @gender
  end

  # POST /genders
  # POST /genders.json
  def create
    @gender = Gender.new(gender_params)

    if @gender.save
      render json: @gender, status: :created, location: @gender
    else
      render json: @gender.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /genders/1
  # PATCH/PUT /genders/1.json
  def update
    @gender = Gender.find(params[:id])

    if @gender.update(gender_params)
      head :no_content
    else
      render json: @gender.errors, status: :unprocessable_entity
    end
  end

  # DELETE /genders/1
  # DELETE /genders/1.json
  def destroy
    @gender.destroy

    head :no_content
  end

  private

    def set_gender
      @gender = Gender.find(params[:id])
    end

    def gender_params
      params[:gender]
    end
end
