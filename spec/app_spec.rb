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

  it "should respond to a real rapper" do
    get '/rating.json?name=eminem'
    last_response.body.should eq '{"rapper":"Eminem","rapper_url":"http://rapgenius.com/artists/Eminem","word_count":92291,"bitch_count":53,"bastard_count":0,"swear_count":312}'
  end
end