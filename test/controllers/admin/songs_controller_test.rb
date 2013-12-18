require_relative '../../test_helper'

class Admin::SongsControllerTest < ActionController::TestCase

  def setup
    # TODO: login as admin user
    @song = songs(:default)
  end

  def test_get_index
    get :index
    assert_response :success
    assert assigns(:songs)
    assert_template :index
  end

  def test_get_show
    get :show, :id => @song
    assert_response :success
    assert assigns(:song)
    assert_template :show
  end

  def test_get_show_failure
    get :show, :id => 'invalid'
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Song not found', flash[:error]
  end

  def test_get_new
    get :new
    assert_response :success
    assert assigns(:song)
    assert_template :new
    assert_select 'form[action=/admin/songs]'
  end

  def test_get_edit
    get :edit, :id => @song
    assert_response :success
    assert assigns(:song)
    assert_template :edit
    assert_select "form[action=/admin/songs/#{@song.id}]"
  end

  def test_creation
    assert_difference 'Song.count' do
      post :create, :song => {
        :name => 'test name',
        :artist => 'test artist',
        :year => 'test year',
      }
      song = Song.last
      assert_response :redirect
      assert_redirected_to :action => :show, :id => song
      assert_equal 'Song created', flash[:success]
    end
  end

  def test_creation_failure
    assert_no_difference 'Song.count' do
      post :create, :song => { }
      assert_response :success
      assert_template :new
      assert_equal 'Failed to create Song', flash[:error]
    end
  end

  def test_update
    put :update, :id => @song, :song => {
      :name => 'Updated'
    }
    assert_response :redirect
    assert_redirected_to :action => :show, :id => @song
    assert_equal 'Song updated', flash[:success]
    @song.reload
    assert_equal 'Updated', @song.name
  end

  def test_update_failure
    put :update, :id => @song, :song => {
      :name => ''
    }
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update Song', flash[:error]
    @song.reload
    refute_equal '', @song.name
  end

  def test_destroy
    assert_difference 'Song.count', -1 do
      delete :destroy, :id => @song
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Song deleted', flash[:success]
    end
  end
end