class EventsController < ApplicationController
  include CalendarHelper
  before_action :set_family
  before_action :set_event, :only => [:destroy, :show]
  before_action :only => [:index] do
    provide_relationships(@family)
  end

  def index
    @event = Event.new
    @permitted_events_by_date = current_person.all_permitted("event").group_by(&:start_date)
  end

  def create
    @event = Event.new(event_params)
    @event.owner = current_person
    @family.events << @event
    @event.permissions = @event.parse(params[:event][:parse_permission])
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
      flash[:alert] = "Sorry, something went wrong."
      render 'show'
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def event_params
    params.require(:event).permit(:name, :content, :start_date, :end_date)
  end
end
