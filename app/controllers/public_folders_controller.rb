class PublicFoldersController < ApplicationController
  add_breadcrumb "Home", :public_folders_path

  def index
    @folders = Folder.where(permission: 'root_global')
  end

  def show
    @folder = Folder.find(params[:id])
    @child_folders = @folder.folders
    @binaries = @folder.binaries
  end

end
