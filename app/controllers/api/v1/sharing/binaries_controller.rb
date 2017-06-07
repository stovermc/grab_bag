class Api::V1::Sharing::BinariesController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
  end

  def show
  end

  private
    def current_user
      @current_user = User.find(doorkeeper_token.resource_owner_id)
    end

    def search_params

    end
end
