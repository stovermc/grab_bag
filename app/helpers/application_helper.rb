module ApplicationHelper

  def current_admin_folder_delete_button(folder)
    if current_admin?
      link_to 'Delete', folder.url, data: {confirm: 'Are you sure? This will delete all the contents inside the folder as well.'}, method: :delete, class: 'btn btn-danger'
    end
  end

  def current_admin_binary_delete_button(binary)
    if current_admin?
      link_to 'Delete', binary.url, data: {confirm: 'Are you sure? This will delete this binary.'}, method: :delete, class: 'btn btn-danger'
    end
  end

  def like_button_once
    if current_user
      if @binary.likes.find_by(user_id: current_user)
        users_dislike_file_path(id: @binary, binary_name: @binary.name, format: :binary, username: current_user.name, route: "route")
      else
        users_like_file_path(id: @binary, binary_name: @binary.name, format: :binary, username: current_user.name, route: "route")
      end
    else
      link_to root_path
    end
  end

  def like_button_text
    if current_user
      if @binary.likes.find_by(user_id: current_user)
        "Unlike File"
      else
        "Like File"
      end
    else
      "Must be signed in to like"
    end
  end

  def comment_like_text(comment)
    if current_user
      if comment.likes.find_by(user_id: current_user.id)
        "Unlike Comment"
      else
        "Like Comment"
      end
    else
      "Must be signed in to like"
    end
  end

  def like_comment(comment)
    if comment.likes.find_by(user_id: current_user)
      users_dislike_comment_path(@binary.folder.owner.username, @binary.folder.route, @binary.name, comment_id: comment.id)
    else
      users_like_comment_path(@binary.folder.owner.username, @binary.folder.route, @binary.name, comment_id: comment.id)
    end
  end

  def glyphicon_type(name_of_class)
    if name_of_class == 'Folder'
    '<span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span>'
    else
    '<span class="glyphicon glyphicon-file" aria-hidden="true"></span>'
    end
  end

end
