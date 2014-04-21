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
        if params[:start_time].blank?
          @event.times_given = false
        else
          @event.times_given = true
          save_time("start")
          save_time("end") 
        end

  
        @event.owner = current_person
        @family.events << @event
        
        @event.save
        f.js { render js: "window.location='#{family_events_path}'" }
      else
        @msg = print_errors_for(@event)
        f.js {render 'create_failure', locals: {msge: @msg}}
      end
    end
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

  def save_time(type)
    type_time = type + "_time"
    split_time = params[type_time.to_sym].split(":").collect(&:to_i)
    date = DateTime.parse(params["event"]["#{type}_date"])
    binding.pry
    @event.start_date = (date + split_time.first.hours + split_time.second.hours.minutes).to_s
  end

  def event_params
    params.require(:event).permit(:name, :content, :start_date, :end_date)
  end
end
