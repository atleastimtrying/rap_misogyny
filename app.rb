require 'sinatra'
require './rapper_data'
require 'pg'
require 'data_mapper'
require 'dm-serializer'
require 'sanitize'

def slugify string
  string.strip.tr(' ', '_').downcase
end

def make_rapper name
  rapper = RapperData.get(name)
  Rapper.create({
    name: rapper[:name],
    slug: slugify(rapper[:name]),
    rating: rapper[:rating],
    url: rapper[:url]
  })
end

def get_rapper name
  Rapper.first(slug: slugify(name)) || make_rapper(name)
end


DataMapper.setup(:default, ENV['HEROKU_POSTGRESQL_JADE_URL'] || ENV['LOCAL_URL'])

class Rapper
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :slug, String
  property :rating, Float
  property :url, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

get '/' do
  erb :index, :locals => { :rappers => Rapper.all }
end

get '/script.js' do
  send_file 'script.js'
end

get '/style.css' do
  send_file 'style.css'
end

get '/favicon.ico' do
  send_file 'favicon.ico'
end

get '/rappers.json' do
  Rapper.all.to_json
end

get '/rating.json' do
  name = Sanitize.clean(params[:name])
  if name
    get_rapper(name).to_json
  else
    'please enter a name'
  end
end