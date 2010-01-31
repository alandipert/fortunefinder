require 'sinatra/base'

class FortuneApp < Sinatra::Base

  # we have to set these because Sinatra::Base is a blank slate
  set :static, true
  set :views, File.dirname(__FILE__) + '/views'
  set :public, File.dirname(__FILE__) + '/public'

  # given a birth year and whether they want dirtyfortune,
  # hook it up
  def get_fortune(birthyear, wants_dirty)

    fortunes=[
     "You will make new friends this year", 
     "You will find yourself particularly lucky in the month of March", 
     "Play games often and you will be surprised how often you will win", 
     "Watch your mouth when your temper gets hot", 
     "You will have great success in many endeavors", 
     "You will receive money in the mail", 
     "You will have success in every aspect of your life", 
     "You will come up with the next great idea of this generation" 
    ] 

    oldfortunes=[
     "Your hip will break", 
     "Your viagara subscription may run out before you know it",
     "You will be hospitalized within the next week for any number of reasons",
     "You will find love but he or she will be toothless",
     "Hold on, you are how old?" 
    ]

    dirtyendings=[
      " in bed during the ride of your life", 
      " with your best friends mom", 
      " with great pride in your own private parts", 
      " with penis in thy ear", 
      " with more than one sex partner at the same time",
      " but your lover will still cheat on you",
      " and you will receive twice the amount of oral sex as usual", 
      " but its too bad you will get chlamydia from a stripper",
      " but sometimes even a blow job won't help you succeed", 
      " but your private parts may not be as safe as you think they are", 
      " with sex toy in hand" 
    ]

    year = Time.now.year

    if birthyear <= year - 18
     # person 18 or older

     if birthyear <= year - 40
       # person's over 40. geezer!
       fortunes = oldfortunes
     end

     if wants_dirty
       # combine fortunes with dirty endings
       fortunes = fortunes.zip(dirtyendings).map{|f, dirty| f + dirty}
     end

     # pick a random fortune
     fortunes[rand(fortunes.length)]

    elsif birthyear > year
      #birthday in the future, BS!
      "That's impossible!"
    else
     # person's a kid. set them straight.
     "Read a book, kid"
    end
  end

  before do
    headers "Content-Type" => "text/html; charset=utf-8" 
  end

  get '/' do
    @title="Fortune Finder 1.0"
    erb :form
  end

  post '/fortune' do
    @title="Your fortune is revealed"
    @fortune = get_fortune(params[:birthyear].to_i, params[:dirtyfortune])
    erb :fortune
  end
end
