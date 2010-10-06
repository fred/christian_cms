require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::UsersController, "Logged in as Admin" do
  
  before(:each) do
    @admin = Factory(:admin)
    login_as(@admin)
    @user = Factory(:visitor)
    @user_valid_attributes = { :login => "blahbla"}
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end
  
  test "should show user" do
    get :show, :id => @user.id
    assert_response :success
  end
  
  test "should get edit" do
    get :edit, :id => @user.id
    assert_response :success
  end
  
  test "should update user" do
    put :update, :id => @user.id, :user => { }
    assert_redirected_to edit_admin_user_path(@user)
  end
  
  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => @user.id
    end
    assert_redirected_to admin_users_path
  end

end

describe Admin::UsersController, "Logged in as normal user" do
  
  before(:each) do
    @user = Factory(:visitor)
    login_as(@user)
  end
  
  test "should get index" do
    get :index
    assert_response 302
    assert_redirected_to new_session_path
  end
  
  test "should show user" do
    get :show, :id => @user.id
    assert_response 302
    assert_redirected_to new_session_path
  end
  
  test "should get edit" do
    get :edit, :id => @user.id
    assert_response 302
    assert_redirected_to new_session_path
  end
  
  test "should update user" do
    put :update, :id => @user.id, :user => { }
    assert_response 302
    assert_redirected_to new_session_path
  end
  
  test "should destroy user" do
    assert_difference('User.count', 0) do
      delete :destroy, :id => @user.id
    end
    assert_redirected_to new_session_path
  end

end


describe Admin::UsersController, "Not logged in" do
  
  before(:each) do
    @user = Factory(:visitor)
  end
  
  test "should get index" do
    get :index
    assert_response 302
    assert_redirected_to new_session_path
  end
  
  test "should show user" do
    get :show, :id => @user.id
    assert_response 302
    assert_redirected_to new_session_path
  end
  
  test "should get edit" do
    get :edit, :id => @user.id
    assert_response 302
    assert_redirected_to new_session_path
  end
  
  test "should update user" do
    put :update, :id => @user.id, :user => { }
    assert_response 302
    assert_redirected_to new_session_path
  end
  
  test "should destroy user" do
    assert_difference('User.count', 0) do
      delete :destroy, :id => @user.id
    end
    assert_redirected_to new_session_path
  end

end
