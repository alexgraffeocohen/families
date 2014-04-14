class EventsController < ApplicationController
  include CalendarHelper

  def index
    @person = current_person
    @events = Event.all
    @events_by_date = @events.group_by(&:start_date)
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    @event.owner = current_person
    redirect_to family_events_path
  end

  def show
    @event = Event.find(params[:event_id])
  end

  def destroy
  end

  private

  def event_params
    params.require(:event).permit(:name, :content, :start_date, :end_date)
  end
end
