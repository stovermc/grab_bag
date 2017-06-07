class Api::V1::BinaryDownloadsByDateController < ApplicationController

  def index
    render json: BinaryDownload.by_date
  end

end