class Place < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :place_recs
  has_many :recommendations, through: :place_recs
  validates :name, presence: true
  
  def list_recommendations
    if self.recommendations.length > 1
      statement = ""
      self.recommendations.each do |rec| 
        if rec!=self.recommendations.last 
          statement += "#{rec.name}, "
        else 
          statement += "and #{rec.name}"
        end
      end 
      return statement
    elsif self.recommendations.length == 1 
       self.recommendations.first.name 
    else 
      "a totally new place to see"
    end 
  end
  
  
  
end