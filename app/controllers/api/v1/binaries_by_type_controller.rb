class Api::V1::BinariesByTypeController < ApplicationController

  def index
    render json: Binary.by_type
  end

end