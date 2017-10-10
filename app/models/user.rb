class User < ApplicationRecord
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
  validates :password, presence: true, length: {minimum: 6}
end
