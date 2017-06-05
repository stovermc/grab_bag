class Api::V1::BinaryDownloadsController < ApplicationController

  def index
    render json: BinaryDownload.by_date
  end

end