class Api::V1::BinaryDownloadsPublicVPrivateController < ApplicationController

  def index
    render json: BinaryDownload.by_permission
  end

end
