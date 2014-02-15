# spec/app_spec.rb
require File.expand_path '../spec_helper.rb', __FILE__

describe "My Sinatra Application" do
  it "should allow accessing the home page" do
    get '/'
    last_response.should be_ok
  end

  it "should load the script.js file" do
    get '/script.js'
    last_response.should be_ok
  end

  it "should load the style.css file" do
    get '/style.css'
    last_response.should be_ok
  end

  it "should return ok for rating.json" do
    get '/rating.json'
    last_response.should be_ok
  end

  it "should respond to a nonsense rapper" do
    get '/rating.json?name=dskjfhgsjkhfsgd'
    last_response.should be_ok
  end

  it "should respond to a nonsense rapper with message" do
    get '/rating.json?name=dskjfhgsjkhfsgd'
    last_response.body.should eq 'no rapper found'
  end
end