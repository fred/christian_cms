require File.dirname(__FILE__) + '/../../spec_helper'

describe "/weathers/new.html.erb" do
  include WeathersHelper
  
  before do
    @weather = mock_model(Weather)
    @weather.stub!(:new_record?).and_return(true)
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

  it "should render new form" do
    render "/weathers/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", weathers_path) do
      with_tag("input#weather_zipcode[name=?]", "weather[zipcode]")
      with_tag("input#weather_city[name=?]", "weather[city]")
      with_tag("input#weather_region[name=?]", "weather[region]")
      with_tag("input#weather_country[name=?]", "weather[country]")
      with_tag("input#weather_temperature_high[name=?]", "weather[temperature_high]")
      with_tag("input#weather_temperature_low[name=?]", "weather[temperature_low]")
      with_tag("input#weather_temperature_units[name=?]", "weather[temperature_units]")
      with_tag("input#weather_link[name=?]", "weather[link]")
    end
  end
end


