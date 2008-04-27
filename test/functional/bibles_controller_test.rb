require File.dirname(__FILE__) + '/../test_helper'

class BiblesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:bibles)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_bible
    assert_difference('Bible.count') do
      post :create, :bible => { }
    end

    assert_redirected_to bible_path(assigns(:bible))
  end

  def test_should_show_bible
    get :show, :id => bibles(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => bibles(:one).id
    assert_response :success
  end

  def test_should_update_bible
    put :update, :id => bibles(:one).id, :bible => { }
    assert_redirected_to bible_path(assigns(:bible))
  end

  def test_should_destroy_bible
    assert_difference('Bible.count', -1) do
      delete :destroy, :id => bibles(:one).id
    end

    assert_redirected_to bibles_path
  end
end
