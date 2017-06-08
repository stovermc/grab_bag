class Users::Folders::Binaries::FileLikesController < ApplicationController
  def create
    if current_user
      @binary = Binary.find_by(name: params[:binary_name])
      if !@binary.likes.find_by(user_id: current_user.id)
        @like = @binary.likes.create(user: current_user)
      end
      redirect_to @binary.url
    end
  end

  def delete
    if current_user
      @binary = Binary.find_by(name: params[:binary_name])
      @binary.likes.find_by(user: current_user).destroy
      redirect_to @binary.url
    end
  end
end
