require 'event_brite'

class EventsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @events = Event.all
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
    respond_to do |format|
      format.json { render :json => data }
    end
  end
end