class User < ActiveRecord::Base
  has_many :businesses
  has_many :recommendations, through: :businesses
  has_secure_password
  
end