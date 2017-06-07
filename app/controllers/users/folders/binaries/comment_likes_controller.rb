class Users::Folders::Binaries::CommentLikesController < ApplicationController
  def create
    if current_user
      @binary = Binary.find_by(name: params[:binary_name])
      comment = @binary.comments.find_by(id: params[:comment_id])
      comment.likes.create(user: current_user)
      redirect_to(@binary.url)
    else
      @binary = Binary.find_by(name: params[:binary_name])
      flash[:danger] = "Log in to add comments and likes."
      redirect_to public_folders_binary_path(@binary)
    end
  end

  def delete
    if current_user
      @binary = Binary.find_by(name: params[:binary_name])
      @comment = @binary.comments.find_by(id: params[:comment_id])
      @comment.likes.find_by(user_id: current_user).destroy
      redirect_to(@binary.url)
    end
  end
end
