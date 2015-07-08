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
        @page = Page.new(page_params)
        @page.save
        respond_with(@page)
    end

    def update
        @page.update(page_params)
        respond_with(@page)
    end

    def destroy
        @page.destroy
        respond_with(@page)
    end

    private
        def set_page
            @page = Page.find(params[:id])
        end

        def page_params
            params.require(:page).permit(:title, :description, :cover, :user_id)
        end
end
