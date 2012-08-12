class Meeting < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :acquaintance, :class_name => "User"

  attr_accessible :acquaintance_first_name, :acquaintance_last_name, :acquaintance_source, :acquaintance_notes
end
