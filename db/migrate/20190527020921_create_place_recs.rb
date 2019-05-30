class CreatePlaceRecs < ActiveRecord::Migration[5.2]
  def change
    create_table :place_recs do |t|
      t.integer :place_id
      t.integer :recommendation_id
    end
  end
end
