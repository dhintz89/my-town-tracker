class User < ActiveRecord::Base
  has_many :places
  has_many :recommendations, through: :places
  has_many :categories, through: :places
  has_secure_password
  
end