class PublicFolders::BinariesController < ApplicationController

  def show
    @current_user = current_user
    @binary = Binary.find(params[:id])
  end
end
