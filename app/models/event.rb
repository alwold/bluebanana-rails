class Event < ActiveRecord::Base
  has_many :meetings
  has_many :checkins
  
  attr_accessible :eventbrite_id, :title, :description, :start, :end, :hashtag, :latitude, :longitude, :foursquare_venue_id
end
