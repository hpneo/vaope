class Place < ActiveRecord::Base

  belongs_to :area
  belongs_to :category
  belongs_to :user
  has_many :phone_numbers

  geocoded_by :address, :latitude => :lat, :longitude => :lng
  reverse_geocoded_by :lat, :lng
  
  MAP_SIZES = {:square => '150x150', :thumb => '300x200', :medium => '600x300', :large => '900x400'}

  def static_map(size)
    "http://maps.google.com/maps/api/staticmap?center=-#{self.lat},#{self.lng}&zoom=16&size=#{Place::MAP_SIZES[size.to_sym]}&markers=#{self.lat},#{self.lng}&sensor=false"
  end
end
