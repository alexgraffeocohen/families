class EventsController < ApplicationController
  include CalendarHelper
  before_action :set_family
  before_action :set_event, :only => [:destroy, :show]
  before_action :only => [:new] do
    provide_relationships(@family)
  end

  def index
    @permitted_events_by_date = current_person.all_permitted("event").group_by(&:start_date)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    
    save_time
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

  def save_time
    start_hours = params[:start_time].split(":").first.to_i
    start_minutes = params[:start_time].split(":").last.to_i
    end_hours = params[:end_time].split(":").first.to_i
    end_minutes = params[:end_time].split(":").last.to_i

    @event.start_date = (DateTime.parse(params["event"]["start_date"]) + start_hours.hours + start_minutes.minutes).to_s
    @event.end_date = (DateTime.parse(params["event"]["end_date"]) + end_hours.hours + end_minutes.minutes).to_s
  end

  def event_params
    params.require(:event).permit(:name, :content, :start_date, :end_date)
  end
end
