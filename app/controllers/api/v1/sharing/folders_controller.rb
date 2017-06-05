class Api::V1::Sharing::FoldersController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    render json: current_user.owned_folders
  end

  def show
    render json: current_user.folder_seach(search_params).children
  end

  private
    def current_user
      @current_user = User.find(doorkeeper_token.resource_owner_id)
    end

    def search_params

    end
end
