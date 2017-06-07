class User < ApplicationRecord
  has_secure_password validations: false

  with_options if: ->(u){u.fb_id.nil?} do |user|
    user.validate do |record|
      record.errors.add(:password, :blank) unless record.password_digest.present?
    end
    user.validates_length_of :password, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
    user.validates_confirmation_of :password, allow_blank: true
  end

  validates :username, presence: true
  validate :check_username_format
  validates :name, presence: true
  validates :status, presence: true
  validates :email, presence: true, uniqueness: true
  validate :check_email_format
  validates :phone, presence: true
  validate :check_phone_format
  validates_uniqueness_of :username, case_sensitive: false

  default_scope { where(status: "active") }
  enum status: %w(active inactive)
  enum role: %w(default admin)

  has_many :shared_folders
  has_many :folders_shared_with, through: :shared_folders, source: :folder
  has_many :owned_folders, class_name: "Folder", foreign_key: "user_id"
  has_many :comments
  has_many :binary_downloads

  after_create :make_home

  def home
    owned_folders.find_by(route: 'home')
  end

  def self.from_omniauth(auth)
    new do |user|
      user.fb_id = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.avatar_url = auth["info"]["image"].insert(4, 's')
      user.token = auth["credentials"]["token"]
    end

  end
  def disable
    self.owned_folders.update_all(status: "inactive")
    self.update(status: "inactive")
  end

  def enable
    Folder.unscoped.where(user_id: self.id).update_all(status: "active")
    self.update(status: "active")
    # self.owned_folders.update_all(status: "inactive")
  end

private
  def check_email_format
    return if errors.key?(:email)
    validates_format_of :email, with: /\A([a-z0-9_\.-]+\@[\da-z\.-]+\.[a-z\.]{2,6})\z/, message: "Address Invalid Format"
  end

  def check_phone_format
    return if errors.key?(:phone)
    validates_format_of :phone, with: /\d{3}[-\s]?\d{3}[-\s]?\d{4}/, message: "Number Invalid Format"
  end

  def check_username_format
    return if errors.key?(:username)
    validates_format_of :username, with: /\A[a-zA-Z]+([a-zA-Z]|\d)*\Z/, message: 'can only contain letters and numbers'
  end

  def make_home
    owned_folders.new(name: 'home', route: 'home', slug: 'home').save(validate: false)
  end
  
  def self.accumulated_by_month
    users_by_month = group("DATE_TRUNC('month', created_at)").count.to_a.sort
    users_by_month.map.with_index do |pair, i|
      {Month: (pair[0]).to_date.strftime("%b %Y"), "Total Number of Users": pair[1] + users_by_month[0...i].inject(0) {|sum,n| n[1] + sum}}
    end
  end

end
