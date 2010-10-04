# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::BuletinsController, "Logged in as Admin" do

  before(:each) do
    @admin = Factory(:admin)
    login_as(@admin)
    @buletin = Factory(:buletin_one)
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:buletins)
  end
  
  test "should get edit" do
    get :edit, :id => @buletin.id
    assert_not_nil assigns(:buletin)
    assert_response :success
  end
  
  test "should update buletin" do
    put :update, :id => @buletin.id, :buletin => { }
    assert_redirected_to admin_buletins_path
  end
  
  # test "should create buletin" do
  #   assert_difference('Buletin.count', +1) do
  #     post :create, 
  #       :buletin => {"uploaded_data"=>"#{Rails.root}/public/test.pdf", "title"=>"Application Form"}
  #   end
  #   assert_redirected_to admin_buletins_path
  # end
  
  # test "should destroy buletin" do
  #   assert_difference('Buletin.count', -1) do
  #     delete :destroy, :id => @buletin.id
  #   end
  #   assert_redirected_to admin_buletins_path
  # end
    
end
