class User < ActiveRecord::Base
  has_many :places
  has_many :recommendations, through: :places
  has_many :categories, through: :places
  validates :name,  presence: true
  validates :username, presence: true, uniqueness: {case_sensitive: false}
  has_secure_password
  
end