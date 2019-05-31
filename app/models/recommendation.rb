class Recommendation < ActiveRecord::Base
  has_many :place_recs
  has_many :places, through: :place_recs
  validates :name, presence: true
  
end