module ApplicationHelper
  def current_admin_delete_button(user, folder)
    if user.current_admin?
      link_to 'Delete', folder.url, data: {confirm: 'Are you sure? This will delete all the contents inside the folder as well.'}, method: :delete, class: 'btn btn-danger'
    end
  end
end
