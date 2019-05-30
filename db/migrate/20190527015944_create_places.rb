class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.integer :user_id
      t.string :category_id
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state_abbr
      t.integer :visited
      t.string :tagline
      t.string :notes
    end
  end
end
