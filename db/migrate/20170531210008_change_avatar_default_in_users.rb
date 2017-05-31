class ChangeAvatarDefaultInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :avatar_url, Faker::Avatar.image
  end
end
