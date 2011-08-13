class Place < ActiveRecord::Base

  belongs_to :area
  belongs_to :category
  belongs_to :user
  has_many :phone_numbers

  scope :near, lambda{ |latlng|
                  latlng = latlng.split(',')
                  lat = latlng[0]
                  lng = latlng[1]
                  {
                    :select => "*, (3959 * ACOS(COS(RADIANS(#{lat})) * COS(RADIANS(lat)) * COS(RADIANS(lng) - RADIANS(#{lng})) + SIN(RADIANS(#{lat})) * SIN(RADIANS(lat)))) AS distance",
                    :having => 'distance < 0.5',
                    :order => 'distance'
                  }
                }
end
