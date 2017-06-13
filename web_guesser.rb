require 'sinatra'
require 'sinatra/reloader'
require 'pry'

set :secret_number, rand(100)
@@times_guessed = 5

get '/' do
  guessed_times
  guess = params["guess"] unless params["cheat"] == 'true'
  message = check_guess(guess)
  color = background_color(message)
  title = title_check(message)
  secret_number = settings.secret_number

  erb :index, :locals => {:secret_number => secret_number,
    :message => message, :color => color, :title => title, :guess => guess,
    :params => params, :guesses_left => guessed_times }
  end

  post '/' do
    settings.secret_number = rand(100)
    @@times_guessed = 6
    redirect "/"
  end

def guessed_times
  if @@times_guessed == 0
    settings.secret_number = rand(100)
    @@times_guessed = 5
    "You have a new number to guess"
  else
    "You have #{@@times_guessed} guesses left to guess correctly"
  end
end

def title_check(message)
  msg = "Guess A Number" unless message.split.include?("right!")
  msg = "CONGRATULATIONS" if message.split.include?("right!")
  msg
end

def check_guess(guess, numb = settings.secret_number)
  msg = "HI!" if guess == nil || guess == "cheat"
  msg = to_high(guess, numb) if guess.to_i > numb
  msg = to_low(guess, numb) if guess.to_i < numb && guess.to_i != 0
  msg = "You got it right!" if guess.to_i == numb
  msg
end


def to_high(guess, secret_number)
  msg = "WAY Too high!" if (guess.to_i) - 5 > secret_number
  msg = "Just a little high" if (guess.to_i) - 5 <= secret_number
  @@times_guessed -= 1
  msg
end

def to_low(guess, secret_number)
  msg = "WAY Too Low!" if (guess.to_i) + 5 < secret_number
  msg = "Just a little low!" if (guess.to_i) + 5 >= secret_number
  @@times_guessed -= 1
  msg
end

def background_color(message)
  color = "#3d4dff" if message == "HI!" || message == "cheat"
  color = "#f74545" if message.split.include?("WAY")
  color = "#efb3b3" if message.split.include?("little")
  color = "#81ff3d" if message.split.include?("right!")
  color
end
