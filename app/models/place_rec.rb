class PlaceRec < ActiveRecord::Base
  belongs_to :place
  belongs_to :recommendation
  
end