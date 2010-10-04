# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

describe ArticlesController do

  before(:each) do
    @article_one = Factory(:article_one)
    @article_two = Factory(:article_two)
    @article_three = Factory(:article_three)
    # @user = Factory.build(:user)  # returns an unsaved object
    # @user = Factory.create(:user) # returns a saved object
    # @user = Factory(:user)        # shortcut for Factory.create()
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:articles)
  end

  test "should show article" do
    get :show, :id => @article_one.id
    assert_not_nil :article
    assert_response :success
  end
  
  test "should show article1 by permalink" do
    get :show, :permalink => @article_one.permalink
    assert_not_nil :article
    assert_response :success
  end
  
  test "should show article2 by permalink" do
    get :show, :permalink => @article_two.permalink
    assert_not_nil :article
    assert_response :success
  end

  test "should not get edit" do
    lambda {get :edit, :id => @article_one.id}.should raise_error(ActionController::UnknownAction)
  end

  test "should not update article" do
    lambda {put :update, :id => @article_one.id, :article => { }}.should raise_error(ActionController::UnknownAction)
  end
  
  test "should not create article" do
    lambda {post :create, :article => {:title => "blah" }}.should raise_error(ActionController::UnknownAction)
  end

  test "should not destroy article" do
    lambda{delete :destroy, :id => @article_one.id}.should raise_error(ActionController::UnknownAction)
  end

end
