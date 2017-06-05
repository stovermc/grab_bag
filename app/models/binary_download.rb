class BinaryDownload < ApplicationRecord
  belongs_to :user
  belongs_to :binary

  def self.by_date
    date_array = group("date(created_at)").count.to_a.sort
    date_array.map.with_index do |pair, i|
      {date: pair[0], accumulated_downloads: pair[1] + date_array[0...i].inject(0) {|sum,n| n[1] + sum}}
    end
  end

  def self.by_permission
    
  end
end
