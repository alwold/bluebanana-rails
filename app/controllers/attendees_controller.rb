class AttendeesController < ApplicationController
  def index
    event = Event.find(params[:id])
    logger.debug "eventbrite id"
    logger.debug event.eventbrite_id
    attendees = EventBrite.get("/event_list_attendees", :query => { :id => event.eventbrite_id, :app_key => "4BVWLKSTKBR2VG2FSL" })

    # TODO clean up data and indicate if the user is checked in
    respond_to do |format|
      format.json { render :json => attendees }
    end
  end
end
