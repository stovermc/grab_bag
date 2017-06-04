class BinaryDownloadsController < ApplicationController
  def new
    binary = Binary.find(params[:binary_id])
    redirect_to binary.data_url
    
    BinaryDownload.create!(user: current_user, binary: binary)
  end
end
