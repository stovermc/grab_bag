class Api::V1::Sharing::FoldersController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    render json: current_user.owned_folders
  end

  def show
    binding.pry
    render json: current_user.folder_search(search_params).children
  end

    def current_user
      @current_user = User.find(doorkeeper_token.resource_owner_id)
    end

    def search_params
      params.permit(:folder_name)
    end
end
