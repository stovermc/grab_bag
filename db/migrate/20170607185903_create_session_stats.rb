class CreateSessionStats < ActiveRecord::Migration[5.0]
  def change
    create_table :session_stats do |t|
      t.datetime :log_in_time
      t.float :duration

      t.timestamps
    end
  end
end
