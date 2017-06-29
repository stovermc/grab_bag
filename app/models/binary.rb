class Binary < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: [:folder_id] }
  validates :extension, presence: true
  validates :data_url, presence: true
  validates :folder, presence: true

  belongs_to :folder
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable
  has_many :binary_downloads, dependent: :nullify

  enum status: %w(active inactive)

  default_scope { where(status: "active") }

  def url
    folder.url + '/' + name + '.' + extension
  end

  def self.by_type
    Rails.cache.fetch("binaries_by_type") do
      types = pluck(:extension).uniq
      types.map {|type| { "File Type" => type, "Total"=> where(extension: type).count}}
    end
  end

  def self.average_per_folder
    Rails.cache.fetch("average_binaries_per_folder") do
      (count.to_f / Folder.count.to_f).round(2)
    end
  end

end
