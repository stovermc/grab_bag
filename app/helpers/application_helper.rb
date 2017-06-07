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

  def like_button_once(binary, user)
    if user
      if binary.likes.find_by(user_id: user)
        link_to users_dislike_file_path(id: binary, binary_name: binary.name, format: :binary, username: user.name, route: "route")
      else
        link_to users_like_file_path(id: binary, binary_name: binary.name, format: :binary, username: user.name, route: "route")
      end
    else
      link_to root_path
    end
  end

  def like_button_text(user)
    if user
      if binary.likes.find_by(user_id: user)
        "Dislike File"
      else
        "Like File"
      end
    else
      "Must be signed in to like"
    end
  end
end
