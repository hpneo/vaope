class Area < ActiveRecord::Base

  has_many :places
  has_many :areas, :foreign_key => 'parent_id'

end
