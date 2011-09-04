class Place < ActiveRecord::Base

  belongs_to :area
  belongs_to :category
  belongs_to :user
  has_many :phone_numbers

  scope :near, lambda{ |latlng, distance = 0.5|
                  latlng = latlng.split(',')
                  lat = latlng[0]
                  lng = latlng[1]

                  case connection.adapter_name.downcase
                    when 'mysql2'
                      {
                        :select => "*, (6371 * ACOS(COS(RADIANS(#{lat})) * COS(RADIANS(lat)) * COS(RADIANS(lng) - RADIANS(#{lng})) + SIN(RADIANS(#{lat})) * SIN(RADIANS(lat)))) AS distance",
                        :having => "distance < #{distance}",
                        :order => 'distance'
                      }
                    else
                      {
                        :select => "*, (ACOS(least(1,COS(#{lat})*COS(#{lng})*COS(RADIANS(lat))*COS(RADIANS(lng))+COS(#{lat})*SIN(#{lng})*COS(RADIANS(lat))*SIN(RADIANS(lng))+SIN(#{lat})*SIN(RADIANS(lat))))*#{distance}) AS distance",
                        :where => "distance < #{distance}",
                        :order => 'distance'
                      }
                  end
                }
  
  MAP_SIZES = {:square => '150x150', :thumb => '300x200', :medium => '600x300', :large => '900x400'}

  def static_map(size)
    "http://maps.google.com/maps/api/staticmap?center=-#{self.lat},#{self.lng}&zoom=16&size=#{Place::MAP_SIZES[size.to_sym]}&markers=#{self.lat},#{self.lng}&sensor=false"
  end
end
