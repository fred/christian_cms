require File.dirname(__FILE__) + '/../../spec_helper'

describe "/weathers/index.html.erb" do
  include WeathersHelper
  
  before do
    weather_98 = mock_model(Weather)
    weather_98.should_receive(:zipcode).and_return("MyString")
    weather_98.should_receive(:city).and_return("MyString")
    weather_98.should_receive(:region).and_return("MyString")
    weather_98.should_receive(:country).and_return("MyString")
    weather_98.should_receive(:temperature_high).and_return("MyString")
    weather_98.should_receive(:temperature_low).and_return("MyString")
    weather_98.should_receive(:temperature_units).and_return("MyString")
    weather_98.should_receive(:link).and_return("MyString")
    weather_98.should_receive(:recorded_at).and_return(Date.today)
    weather_98.should_receive(:created_at).and_return(Time.now)
    weather_98.should_receive(:updated_at).and_return(Time.now)
    weather_99 = mock_model(Weather)
    weather_99.should_receive(:zipcode).and_return("MyString")
    weather_99.should_receive(:city).and_return("MyString")
    weather_99.should_receive(:region).and_return("MyString")
    weather_99.should_receive(:country).and_return("MyString")
    weather_99.should_receive(:temperature_high).and_return("MyString")
    weather_99.should_receive(:temperature_low).and_return("MyString")
    weather_99.should_receive(:temperature_units).and_return("MyString")
    weather_99.should_receive(:link).and_return("MyString")
    weather_99.should_receive(:recorded_at).and_return(Date.today)
    weather_99.should_receive(:created_at).and_return(Time.now)
    weather_99.should_receive(:updated_at).and_return(Time.now)

    assigns[:weathers] = [weather_98, weather_99]
  end

  it "should render list of weathers" do
    render "/weathers/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end

