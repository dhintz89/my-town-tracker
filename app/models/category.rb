class Category < ActiveRecord::Base
  has_many :places
  has_many :recommendations, through: :places
  has_many :users, through: :places
  validates :name, presence: true
  
end