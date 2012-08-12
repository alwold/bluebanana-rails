require 'event_brite'

class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :checkin, :meeting]

  def index
    @events = Event.all

    respond_to do |format|
      format.html
      format.json { render :json => @events }
    end
  end

  def new
    @event = Event.new
  end

  def create
    event = Event.new(params[:event])
    event.save!

    redirect_to events_path
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    event = Event.find(params[:id])
    event.update_attributes(params[:event])

    redirect_to events_path
  end

  def eventbrite
    raw_data = EventBrite.get("/event_get", :query => { :id => params[:id], :app_key => "4BVWLKSTKBR2VG2FSL"})
    data = Hash.new
    data["title"] = raw_data["event"]["title"]
    data["description"] = raw_data["event"]["description"]
    data["start"] = raw_data["event"]["start_date"]
    data["end"] = raw_data["event"]["end_date"]
    data["latitude"] = raw_data["event"]["venue"]["latitude"]
    data["longitude"] = raw_data["event"]["venue"]["longitude"]
    respond_to do |format|
      format.json { render :json => data }
    end
  end

  def checkin
    checkin = Checkin.new
    checkin.user = User.find(params[:user_id])
    checkin.event = Event.find(params[:id])
    checkin.save!

    respond_to do |format|
      format.json { render :json => { :checkin_id => checkin.id } }
    end
  end

  def meeting
    meeting = Meeting.new
    meeting.event = Event.find(params[:id])
    meeting.user = User.find(params[:user_id])
    if params[:acquaintance_id]
      meeting.acquaintance = User.find(params[:acquaintance_id])
    end
    meeting.acquaintance_first_name = params[:acquaintance_first_name]
    meeting.acquaintance_last_name = params[:acquaintance_last_name]
    meeting.acquaintance_source = params[:acquaintance_source]
    meeting.notes = params[:notes]
    meeting.save!

    respond_to do |format|
      format.json { render :json => { :meeting_id => meeting.id } }
    end
  end
end