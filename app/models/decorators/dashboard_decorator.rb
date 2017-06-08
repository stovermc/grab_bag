class Decorators::DashboardDecorator
  def initialize
  end

  def average_binaries_per_folder
    Rails.cache.fetch("average_binaries_per_folder") do
      Binary.average_per_folder
    end
  end

  def user_count
    Rails.cache.fetch("user_count") do
      User.count
    end
  end

  def folder_count
    Rails.cache.fetch("folder_count") do
      Folder.count
    end
  end

  def binary_count
    Rails.cache.fetch("binary_count") do
      Binary.count
    end
  end
  
  def average_session_duration
    SessionStat.average_duration
  end
end
