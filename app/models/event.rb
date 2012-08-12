class Event < ActiveRecord::Base
  has_many :meetings
  
  attr_accessible :eventbrite_id, :title, :description, :start, :end, :hashtag, :latitude, :longitude
end
