require_relative '../../test_helper'

class Admin::EventsControllerTest < ActionController::TestCase

  def setup
    # TODO: login as admin user
    @event = events(:default)
  end

  def test_get_index
    get :index
    assert_response :success
    assert assigns(:events)
    assert_template :index
  end

  def test_get_show
    get :show, :id => @event
    assert_response :success
    assert assigns(:event)
    assert_template :show
  end

  def test_get_show_failure
    get :show, :id => 'invalid'
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Event not found', flash[:error]
  end

  def test_get_new
    get :new
    assert_response :success
    assert assigns(:event)
    assert_template :new
    assert_select 'form[action=/admin/events]'
  end

  def test_get_edit
    get :edit, :id => @event
    assert_response :success
    assert assigns(:event)
    assert_template :edit
    assert_select "form[action=/admin/events/#{@event.id}]"
  end

  def test_creation
    assert_difference 'Event.count' do
      post :create, :event => {
        :name => 'test name',
        :date => 'test date',
        :location => 'test location',
        :fb_link => 'test fb_link',
      }
      event = Event.last
      assert_response :redirect
      assert_redirected_to :action => :show, :id => event
      assert_equal 'Event created', flash[:success]
    end
  end

  def test_creation_failure
    assert_no_difference 'Event.count' do
      post :create, :event => { }
      assert_response :success
      assert_template :new
      assert_equal 'Failed to create Event', flash[:error]
    end
  end

  def test_update
    put :update, :id => @event, :event => {
      :name => 'Updated'
    }
    assert_response :redirect
    assert_redirected_to :action => :show, :id => @event
    assert_equal 'Event updated', flash[:success]
    @event.reload
    assert_equal 'Updated', @event.name
  end

  def test_update_failure
    put :update, :id => @event, :event => {
      :name => ''
    }
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update Event', flash[:error]
    @event.reload
    refute_equal '', @event.name
  end

  def test_destroy
    assert_difference 'Event.count', -1 do
      delete :destroy, :id => @event
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Event deleted', flash[:success]
    end
  end
end