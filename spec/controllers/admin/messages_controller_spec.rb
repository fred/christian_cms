require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::MessagesController do
  
  before(:each) do
    setting1=Factory(:notifications_email)
    setting2=Factory(:site_email)
    @admin = Factory(:admin)
    login_as(@admin)
    @message = Factory(:message_one)
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messages)
  end
  
  test "should show message" do
    get :show, :id => @message.id
    assert_response :success
  end
  
  test "should get edit" do
    get :edit, :id => @message.id
    assert_response :success
  end
  
  test "should update message" do
    put :update, :id => @message.id, :message => { }
    assert_redirected_to admin_messages_path
  end
  
  test "should destroy message" do
    assert_difference('Message.count', -1) do
      delete :destroy, :id => @message.id
    end
  
    assert_redirected_to admin_messages_path
  end
  

end
