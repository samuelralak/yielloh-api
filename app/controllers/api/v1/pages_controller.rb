class Api::V1::PagesController < ApplicationController
    before_action :doorkeeper_authorize!
    before_action :set_page, only: [:show, :edit, :update, :destroy]

    def index
        @pages = Page.all
        respond_with(@pages)
    end

    def show
        respond_with(@page)
    end

    def create
        @page = current_user.pages.new(page_params)

        if @page.save
            render json: @page, status: :created, location: @api_page
        else
            render json: @page.errors, status: :unprocessable_entity
        end
    end

    def update
        if @page.update(page_params)
            render json: @page, status: :ok, location: @api_page
        else
            render json: @page.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @page.destroy
        render json: { message: "page successfully deleted"}, status: :ok
    end

    private
        def set_page
            @page = Page.find(params[:id])
        end

        def page_params
            params.require(:page).permit(:title, :description, :cover, :user_id)
        end
end
