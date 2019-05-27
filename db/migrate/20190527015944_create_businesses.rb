class CreateBusinesses < ActiveRecord::Migration[5.2]
  def change
    create_table :businesses do |t|
      t.integer :user_id
      t.string :name
      t.string :type
      t.string :location
      t.integer :visited
      t.string :tagline
      t.string :notes
    end
  end
end
