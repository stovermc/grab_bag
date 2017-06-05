class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :binary
  has_many :likes, as: :likeable

  validates :binary, presence: true
  validates :text, presence: true
end
