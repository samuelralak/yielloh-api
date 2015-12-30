class Api::V1::TagsController < ApplicationController
    before_action :doorkeeper_authorize!

    def index
        @tags = ActsAsTaggableOn::Tag.all
        respond_with(@tags)
    end

    def show

    end

    def create

    end

    def update

    end

    def destroy

    end

    def list
        
    end
end
