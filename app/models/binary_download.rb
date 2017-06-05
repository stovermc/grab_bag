class BinaryDownload < ApplicationRecord
  belongs_to :user
  belongs_to :binary

  def self.by_date
    select("date(created_at)").group("date(created_at)")
    # find_by_sql(["
    #   select created_at as date
    #   from binary_downloads
    #   group by created_at
    #   "])
  end
end
