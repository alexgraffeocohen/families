class EventsController < ApplicationController
  include CalendarHelper
  before_action :set_family
  before_action :set_event, :only => [:destroy, :show]
  before_action :only => [:new] do
    provide_relationships(@family)
  end

  def index
    @permitted_events_by_date = current_person.all_permitted("event").group_by(&:formatted_date)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.permissions = @event.parse(params[:event][:parse_permission])
    respond_to do |f|
      if @event.valid?
        save_time("start") unless params[:start_time].nil?
        save_time("end") unless params[:end_time].nil?
  
        @event.owner = current_person
        @family.events << @event
        
        @event.save
        f.js { render js: "window.location='#{family_events_path}'" }
      else
        @msg = print_errors_for(@event)
        f.js {render 'layouts/create_failure', locals: {msge: @msg}}
      end
    end
  end

  def show
  end

  def destroy
    destroy_response(@event)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def save_time(period)
    period_hours = params["#{period}_time".to_sym].split(":").first.to_i
    period_minutes = params["#{period}_time".to_sym].split(":").second.to_i
    parsed_date = DateTime.parse(params["event"]["#{period}_date"])
    date_with_time = (parsed_date + period_hours.hours + period_minutes.minutes).to_s

    @event.send("#{period}_date=".to_sym, date_with_time)
  end

  def event_params
    params.require(:event).permit(:name, :content, :start_date, :end_date)
  end
end
