class BinaryDownload < ApplicationRecord
  belongs_to :user
  belongs_to :binary

  def self.by_date
    Rails.cache.fetch("binary_downloads_by_date") do
      date_array = group("date(created_at)").count.to_a.sort
      date_array.map.with_index do |pair, i|
        {Date: pair[0], "Number of Downloads": pair[1]}
      end
    end
  end

  def self.by_permission
    Rails.cache.fetch("binary_downloads_by_permission") do
      personal = joins(binary: :folder).where(folders: { permission: 0 }).count
      global = count - personal

      [{permission: 'Public', downloads: global}, {permission: 'Private', downloads: personal}]
    end
  end
end
