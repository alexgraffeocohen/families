class EventsController < ApplicationController
  def index
    @person = current_person
    @events = Event.all
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    @event.owner = current_person
    redirect_to family_events_path
  end

  def destroy
  end

  private

  def event_params
    params.require(:event).permit(:name, :content, :start_date, :end_date)
  end
end
