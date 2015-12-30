class Api::V1::PagesController < ApplicationController
    before_action :doorkeeper_authorize!
    before_action :process_cover, only: [:create, :update]
    before_action :set_page,      only: [:show, :edit, :update, :destroy]

    def index
        @pages = current_user.pages.all
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

    def my_pages
        @pages = current_user.pages.all
        respond_with(@pages)         
    end

    private
        def set_page
            @page = Page.find(params[:id])
        end

        def page_params
            params.require(:page).permit(:title, :description, :cover, :user_id)
        end

        def process_cover
            if params[:page] && params[:page][:cover]
                data = StringIO.new(Base64.decode64(params[:page][:cover][:data]))
                data.class.class_eval { attr_accessor :original_filename, :content_type }
                data.original_filename = params[:page][:cover][:filename]
                data.content_type = params[:page][:cover][:content_type]
                params[:page][:cover] = data
            end
        end
end
