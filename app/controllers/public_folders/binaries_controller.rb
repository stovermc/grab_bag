class PublicFolders::BinariesController < ApplicationController
  add_breadcrumb "Home", :public_folders_path

  def show
    @current_user = current_user
    @binary = Binary.find(params[:id])
    add_breadcrumb "#{@binary.folder.name}", public_folder_path(@binary.folder)
  end
end
