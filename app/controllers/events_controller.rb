class EventsController < ApplicationController
  include CalendarHelper
  before_action :set_family
  before_action :set_event, :only => [:destroy, :show]
  before_action :set_owner, :only => [:destroy, :show]
  before_action :only => [:index] do
    provide_relationships(@family)
  end

  def index
    @person = current_person
    @events = Event.all
    @events_by_date = @events.group_by(&:start_date)
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.owner = current_person
    @event.save
    redirect_to family_events_path
  end

  def show
  end

  def destroy
    if current_person == @event.owner
      @event.destroy
      redirect_to family_events_path
    else
      flash[:alert] = "Sorry, you did not create this event."
      render 'show'
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_owner
    @person = Person.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :content, :start_date, :end_date)
  end
end
