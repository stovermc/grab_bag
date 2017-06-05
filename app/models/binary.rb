class Binary < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: [:folder_id] }
  validates :extension, presence: true
  validates :data_url, presence: true


  belongs_to :folder
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable
  has_many :binary_downloads

  enum status: %w(active inactive)

  default_scope { where(status: "active") }
  def url
    folder.url + '/' + name + '.' + extension
  end
end
