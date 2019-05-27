class Recommendation < ActiveRecord::Base
  has_many :bus_recs
  has_many :businesses, through: :bus_recs
  
end