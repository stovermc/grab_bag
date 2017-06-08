class Api::V1::LogInsByWeekdayController < ApplicationController

  def index
    render json: SessionStat.log_ins_by_weekday
  end

end