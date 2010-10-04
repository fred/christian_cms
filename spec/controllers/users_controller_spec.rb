require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController, "Not logged in" do
  
  before(:each) do
    @user = Factory(:visitor)
    @user_valid_attributes = { 
      :login => "blahblah", 
      :email => "email@bugus.com", 
      :password => "password", 
      :password_confirmation => "password"
    }
  end
  
  test "should show list of users" do
    get :index
    assert_response 200
    assert_not_nil assigns(:users)
  end

  test "should not show user but redirect to users list" do
    get :show, :id => @user.id
    assert_response 302
    assert_redirected_to users_path
  end

  test "should not get edit but redirect to login page" do
    get :edit, :id => @user.id
    assert_response 302
    assert_redirected_to new_session_path
  end

  test "should not update user but redirect to login page" do
    put :update, :id => @user.id, :user => {}
    assert_response 302
    assert_redirected_to new_session_path
  end

end


describe UsersController, "Logged in as normal user" do

  before(:each) do
    @visitor = Factory(:visitor)
    login_as(@visitor)
  end

  test "should get index" do
    get :index
    assert_response 200
    assert_not_nil assigns(:users)
    assert_not_nil assigns(:current_user)
  end
  
  test "should show user" do
    get :show, :id => @visitor.id
    assert_response :success
    assert_not_nil assigns(:current_user)
  end
  
  test "should get edit" do
    get :edit
    assert_response :success
    assert_not_nil assigns(:current_user)
  end
  
  test "should update user" do
    put :update, :user => { }
    assert_redirected_to user_path(@visitor)
  end
  
end
