class Api::V1::AccumulatedUsersByMonthController < ApplicationController

  def index
    render json: User.accumulated_by_month
  end

end