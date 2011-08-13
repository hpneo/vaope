class AddDefaultToParentId < ActiveRecord::Migration
  def self.up
    change_column :categories, :parent_id, :integer, :default => 0
  end

  def self.down
  end
end
