class CreateBusRecs < ActiveRecord::Migration[5.2]
  def change
    create_table :bus_recs do |t|
      t.integer :business_id
      t.integer :recommendation_id
    end
  end
end
