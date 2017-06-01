class PublicFoldersController < ApplicationController

  def index
    @folders = Folder.where(permission: 'root_global')
  end

  def show
    @folder = Folder.find(params[:id])
    @child_folders = @folder.folders
    @binaries = @folder.binaries
  end

end
