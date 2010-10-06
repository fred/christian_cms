require File.dirname(__FILE__) + '/../spec_helper'

describe MessagesController do
  
  before(:each) do
    setting1=Factory(:notifications_email)
    setting2=Factory(:site_email)
    @message_one = Factory(:message_one)
    @message_valid_attributes = { 
      :name => "my name", 
      :email => "email@bugus.com", 
      :body => "message body" 
    }
  end
  
  test "should get index" do
    get :index
    assert_response :redirect
    assert_redirected_to new_message_path
  end
  
  test "should create Message" do
    assert_difference('Message.count') do
      post :create, :message => @message_valid_attributes
    end
    assert_redirected_to thank_you_messages_path
  end
  
  test "should not get edit" do
    lambda {get :edit, :id => @message_one.id}.should raise_error(ActionController::UnknownAction)
  end

  test "should not update message" do
    lambda {put :update, :id => @message_one.id, :message => { }}.should raise_error(ActionController::UnknownAction)
  end

  test "should not destroy message" do
    lambda{delete :destroy, :id => @message_one.id}.should raise_error(ActionController::UnknownAction)
  end

end
