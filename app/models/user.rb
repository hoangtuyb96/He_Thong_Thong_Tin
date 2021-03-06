class User < ApplicationRecord
  attr_accessor :remember_token
  before_save {email.downcase!}

  has_many :microposts, dependent: :destroy

  validates :name,  presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},   
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :phone, length: {is: 10, message: "So dien thoai khong hop le"}
  validate :check_head_phone
  validate :check_birthday
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_blank: true

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?remember_token
  end

  def forget
    update_attributes remember_digest: nil
  end

  private
  
  def check_head_phone
    if phone && phone[0].to_i != 0
      errors.add :phone, "So dien thoai phai bat dau bang so 0"
    end
  end
  
  def check_birthday
    if birthday && birthday.to_date > Date.today - 9.years || birthday.to_date < Date.today - 70.years
      errors.add :birthday, "Ngay sinh khong hop le"
    end
  end

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end
  end
end
