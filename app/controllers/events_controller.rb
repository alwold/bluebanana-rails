class EventsController < ApplicationController
  before_filter :authenticate_user!
end