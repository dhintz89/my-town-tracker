class Business < ActiveRecord::Base
  belongs_to :user
  has_many :bus_recs
  has_many :businesses, through: :bus_recs
  
end