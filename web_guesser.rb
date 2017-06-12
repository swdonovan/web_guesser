require 'sinatra'
require 'sinatra/reloader'

secret_number = rand(99)

get '/' do
  erb :index, :locals => {:secret_number => secret_number }
end
