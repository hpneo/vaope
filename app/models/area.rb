class Area < ActiveRecord::Base

  has_many :places
  has_many :areas, :foreign_key => 'parent_id'
  
  scope :near, lambda{ |lat, lng|
                  {
                    :select => "*, (6371 * ACOS(COS(RADIANS(#{lat})) * COS(RADIANS(lat)) * COS(RADIANS(lng) - RADIANS(#{lng})) + SIN(RADIANS(#{lat})) * SIN(RADIANS(lat)))) AS distance",
                    :having => 'distance < 5',
                    :order => 'distance'
                  }
                }

end
