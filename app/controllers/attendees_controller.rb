require 'event_brite'

class AttendeesController < ApplicationController
  def index
    @event = Event.find(params[:id])
    if params[:user_id]
      user = User.find(params[:user_id])
    end
    logger.debug "eventbrite id"
    logger.debug @event.eventbrite_id
    attendees_raw = EventBrite.get("/event_list_attendees", :query => { :id => @event.eventbrite_id, :app_key => "4BVWLKSTKBR2VG2FSL" })
    @attendees = Array.new
    attendees_raw["attendees"].each do |attendee_raw|
      attendee = Hash.new
      attendee["first_name"] = attendee_raw["attendee"]["first_name"]
      attendee["last_name"] = attendee_raw["attendee"]["last_name"]
      attendee["source"] = "Eventbrite attendee"
      find_met_before(user, attendee)
      @attendees.push attendee
    end
    # find attendees that are checked in but not in eventbrite
    @event.checkins.each do |checkin|
      if @attendees.select { |attendee| attendee["first_name"] == checkin.user.first_name && attendee["last_name"] == checkin.user.last_name }.empty?
        attendee = Hash.new
        attendee["first_name"] = checkin.user.first_name
        attendee["last_name"] = checkin.user.last_name
        attendee["source"] = "Loop checkin"
        find_met_before(user, attendee)
        @attendees.push attendee
      end
    end
    # find tweets
    found = Array.new
    if !@event.hashtag.blank?
      logger.debug "hash is #{@event.hashtag}"
      Twitter.search(@event.hashtag, :rpp => 1000).results.map do |tweet|
        attendee = Hash.new
        user = tweet.from_user
        if !found.include?(user)
          found.push user
          name = tweet.from_user_name.split(" ")
          attendee["first_name"] = name.first
          if name.length > 1
            attendee["last_name"] = name.last
          end
          attendee["source"] = "Twitter"
          find_met_before(user, attendee)
          @attendees.push attendee
        end
      end
    end
    # foursquare
    # if !@event.foursquare_venue_id.blank?
    #   consumer_key = "C3SJ2IEANRC5RUKY4R5WDLSCCUIIKNTKPAYJOOCRC4NRAC52"
    #   consumer_secret = "1JVGY2LXZX4MPU50DGW1G14UZCFGIWNYWWXCOSNIBJU1WWJS"
    #   # OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    #   client = Foursquare2::Client.new(:client_id => consumer_key, :client_secret => consumer_secret,
    #     :ssl => { :verify_mode => OpenSSL::SSL::VERIFY_NONE })
    #   # '/usr/lib/ssl/certs/ca-certificates.crt'
    #   venue = client.venue(@event.foursquare_venue_id)
    #   debugger
    # end
    respond_to do |format|
      format.html
      format.json { render :json => @attendees }
    end
  end

  private

  def find_met_before(user, attendee)
    if user
      met_before_at = Array.new
      Event.joins(:meetings).where(:meetings => 
        {:acquaintance_first_name => attendee["first_name"], :acquaintance_last_name => attendee["last_name"], :user_id => user}
        ).each do |event|
        met_before_at.push event
      end
      attendee["met_before_at"] = met_before_at
    end
  end
end
