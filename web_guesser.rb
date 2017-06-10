require 'sinatra'
require 'sinatra/reloader'

secret_number = rand(99)

get '/' do
   "The secret number is #{secret_number}".upcase!
end


class WebGuesser
  attr_reader :secret_number

  def initialize
    secret_number = rand(99)
    puts "The secret number is #{secret_number}"
  end
end
