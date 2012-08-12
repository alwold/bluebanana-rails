class Event < ActiveRecord::Base
  attr_accessible :eventbrite_id, :title, :description, :start, :end, :hashtag
end
