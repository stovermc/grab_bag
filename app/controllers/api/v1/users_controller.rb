class Api::V1::UsersController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    render json: current_user.owned_folders
  end

  private
    def current_user
      @current_user = User.find(doorkeeper_token.resource_owner_id)
    end
end
