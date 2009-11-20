require File.dirname(__FILE__) + '/../spec_helper'

describe ArticlesController do
  
  def setup
    @article = Factory(:article_one)
  end
    
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:articles)
  end

  test "should show article" do
    get :show, :id => @article.id
    assert_response :success
  end

  test "should not get edit" do
    lambda {get :edit, :id => @article.id}.should raise_error(ActionController::UnknownAction)
  end

  test "should not update article" do
    lambda {put :update, :id => @article.id, :article => { }}.should raise_error(ActionController::UnknownAction)
  end

  test "should not destroy article" do
    lambda{delete :destroy, :id => @article.id}.should raise_error(ActionController::UnknownAction)
  end
  

end
