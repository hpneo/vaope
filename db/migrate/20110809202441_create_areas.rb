class CreateAreas < ActiveRecord::Migration
  def self.up
    create_table :areas do |t|
      t.string :name
      t.integer :parent_id
      t.decimal :lat, :precision => 10, :scale => 8
      t.decimal :lng, :precision => 10, :scale => 8
      t.text :description
      t.string :area_code

      t.timestamps
    end
  end

  def self.down
    drop_table :areas
  end
end
