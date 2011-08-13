class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.string :name
      t.integer :category_id
      t.integer :area_id
      t.string :address
      t.text :description
      t.string :url
      t.decimal :lat, :precision => 10, :scale => 8
      t.decimal :lng, :precision => 10, :scale => 8
      t.decimal :rating, :default => 0, :precision => 3, :scale => 2
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :places
  end
end
