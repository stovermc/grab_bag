class Decorators::DashboardDecorator
  def initialize
  end

  def average_binaries_per_folder
    Binary.average_per_folder
  end

  def user_count
    User.count
  end

  def folder_count
    Folder.count
  end

  def binary_count
    Binary.count
  end
  
  def average_session_duration
    SessionStat.average_duration
  end
end
