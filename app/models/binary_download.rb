class BinaryDownload < ApplicationRecord
  belongs_to :user
  belongs_to :binary

  def self.by_date
    date_array = group("date(created_at)").count.to_a.sort
    date_array.map.with_index do |pair, i|
      {Date: pair[0].strftime("%m-%d-%y"), "Accumulated Downloads": pair[1] + date_array[0...i].inject(0) {|sum,n| n[1] + sum}}
    end
  end

  def self.by_permission
    personal = joins(binary: :folder).where(folders: { permission: 0 }).count
    global = count - personal

    [{permission: 'Public Downloads', downloads: global}, {permission: 'Private Downloads', downloads: personal}]
  end
end
