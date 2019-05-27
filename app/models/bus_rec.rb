class BusRec < ActiveRecord::Base
  belongs_to :business
  belongs_to :recommendation
  
end