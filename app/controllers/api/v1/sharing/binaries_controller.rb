class Api::V1::Sharing::BinariesController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    render json: current_user.binaries
  end

  def show
    render json: current_user.binaries.find(input_params[:id])
  end

  private
    def current_user
      @current_user = User.find(doorkeeper_token.resource_owner_id)
    end

    def input_params
      params.permit(:id)
    end
  end
