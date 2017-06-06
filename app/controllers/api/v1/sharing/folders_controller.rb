class Api::V1::Sharing::FoldersController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    render json: current_user.owned_folders
  end

  def show
     folder_contents = current_user.folder_search(input_params[:id])
     render json: folder_contents
  end

    def current_user
      @current_user = User.find(doorkeeper_token.resource_owner_id)
    end
private
    def input_params
      params.permit(:id)
    end
end
