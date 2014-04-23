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
    create_block(@event)
  end

  def create_block(event)
    respond_to do |f|
      if @event.valid?
        save_times
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
  
  def save_times
    save_time("start") unless params[:start_time].nil?
    save_time("end") unless params[:end_time].nil?
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def save_time(period)
    date_with_time = (parsed_date(period) + period_hours(period).hours + period_minutes(period).minutes).to_s
    @event.send("#{period}_date=".to_sym, date_with_time)
  end

  def period_hours(period)
    params["#{period}_time".to_sym].split(":").first.to_i
  end

  def period_minutes(period)
    params["#{period}_time".to_sym].split(":").second.to_i
  end

  def parsed_date(period)
    DateTime.parse(params["event"]["#{period}_date"])
  end

  def event_params
    params.require(:event).permit(:name, :content, :start_date, :end_date)
  end
end
