require 'event_brite'

class AttendeesController < ApplicationController
  def index
    event = Event.find(params[:id])
    if params[:user_id]
      user = User.find(params[:user_id])
    end
    logger.debug "eventbrite id"
    logger.debug event.eventbrite_id
    attendees_raw = EventBrite.get("/event_list_attendees", :query => { :id => event.eventbrite_id, :app_key => "4BVWLKSTKBR2VG2FSL" })
    attendees = Array.new
    attendees_raw["attendees"].each do |attendee_raw|
      attendee = Hash.new
      attendee["first_name"] = attendee_raw["attendee"]["first_name"]
      attendee["last_name"] = attendee_raw["attendee"]["last_name"]
      # see if attendee was met before
      if user
        met_before_at = Array.new
        Event.joins(:meetings).where(:meetings => 
          {:acquaintance_first_name => attendee["first_name"], :acquaintance_last_name => attendee["last_name"], :user_id => user}
          ).each do |event|
          met_before_at.push event
        end
        attendee["met_before_at"] = met_before_at
      end
      attendees.push attendee
    end
    # TODO find attendees that are checked in but not in eventbrite
    event.checkins.each do |checkin|
      if attendees.select { |attendee| attendee.first_name == checkin.user.first_name && attendee.last_name == checkin.user.last_name }.empty?
        attendee = Hash.new
        attendee["first_name"] = checkin.user.first_name
        attendee["last_name"] = checkin.user.last_name
        if user
          met_before_at = Array.new
          Event.joins(:meetings).where(:meetings => 
            {:acquaintance_first_name => attendee["first_name"], :acquaintance_last_name => attendee["last_name"], :user_id => user}
            ).each do |event|
            met_before_at.push event
          end
          attendee["met_before_at"] = met_before_at
        end
        attendees.push attendee
      end
    end
    respond_to do |format|
      format.json { render :json => attendees }
    end
  end
end
