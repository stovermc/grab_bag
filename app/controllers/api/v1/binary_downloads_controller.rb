class Api::V1::BinaryDownloadsController < ApplicationController

  def index
    render json: BinaryDownload.all
  end

end
