class Place < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :place_recs
  has_many :recommendations, through: :place_recs
  validates :name, presence: true
  
end