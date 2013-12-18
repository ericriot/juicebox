class Admin::EventsController < Admin::Cms::BaseController

  before_action :build_event,  :only => [:new, :create]
  before_action :load_event,   :only => [:show, :edit, :update, :destroy]

  def index
    @events = Event.page(params[:page])
  end

  def show
    render
  end

  def new
    render
  end

  def edit
    render
  end

  def create
    @event.save!
    flash[:success] = 'Event created'
    redirect_to :action => :show, :id => @event
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to create Event'
    render :action => :new
  end

  def update
    @event.update_attributes!(event_params)
    flash[:success] = 'Event updated'
    redirect_to :action => :show, :id => @event
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to update Event'
    render :action => :edit
  end

  def destroy
    @event.destroy
    flash[:success] = 'Event deleted'
    redirect_to :action => :index
  end

protected

  def build_event
    @event = Event.new(event_params)
  end

  def load_event
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Event not found'
    redirect_to :action => :index
  end

  def event_params
    params.fetch(:event, {}).permit(:name, :date, :location, :fb_link)
  end
end