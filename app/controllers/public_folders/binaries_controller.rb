class PublicFolders::BinariesController < ApplicationController

  def show
    @binary = Binary.find(params[:id])
  end
end
