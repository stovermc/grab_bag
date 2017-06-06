class Users::Folders::Binaries::CommentLikesController < ApplicationController
  def create
    if current_user
      binary = Binary.find_by(name: params[:binary_name])
      user = binary.folder.owner
      comment = binary.comments.find_by(id: params[:comment_id])
      like = comment.likes.create(user: user)
      redirect_to(binary.url)
    else
      binary = Binary.find_by(name: params[:binary_name])
      flash[:danger] = "Log in to add comments and likes."
      redirect_to public_folders_binary_path(binary)
    end
  end
end
