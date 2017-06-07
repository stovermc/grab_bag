class ChangeSessionStatsLogInToDayofWeek < ActiveRecord::Migration[5.0]
  def change
    remove_column :session_stats, :log_in_time
    add_column :session_stats, :log_in_day, :string
  end
end
