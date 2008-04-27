require File.dirname(__FILE__) + '/../../spec_helper'

describe "/weathers/show.html.erb" do
  include WeathersHelper
  
  before do
    @weather = mock_model(Weather)
    @weather.stub!(:zipcode).and_return("MyString")
    @weather.stub!(:city).and_return("MyString")
    @weather.stub!(:region).and_return("MyString")
    @weather.stub!(:country).and_return("MyString")
    @weather.stub!(:temperature_high).and_return("MyString")
    @weather.stub!(:temperature_low).and_return("MyString")
    @weather.stub!(:temperature_units).and_return("MyString")
    @weather.stub!(:link).and_return("MyString")
    @weather.stub!(:recorded_at).and_return(Date.today)
    @weather.stub!(:created_at).and_return(Time.now)
    @weather.stub!(:updated_at).and_return(Time.now)

    assigns[:weather] = @weather
  end

  it "should render attributes in <p>" do
    render "/weathers/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end

