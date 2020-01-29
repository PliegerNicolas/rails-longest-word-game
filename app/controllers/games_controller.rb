class GamesController < ApplicationController
  def index
  end

  def new
    @letters = (1..10).map { ('a'..'z').to_a.sample.upcase }
    @start_time = Time.now
  end

  def score
    # Time
    time = "You took #{(Time.now - Time.parse(params[:start_time])).round(3)} secondes to find your word."
    @result = { time: time, score: 0, message: '' }

    guess = params[:guess]
    grid = params[:grid].split(' ')

    url = "https://wagon-dictionary.herokuapp.com/#{guess}"
    response = RestClient.get(url)
    wordtester = JSON.parse(response.body)

    if wordtester['found']
      if guess.upcase.split('').all? do |letter|
        guess.upcase.split('').count(letter) <= grid.count(letter)
      end
        @result[:message] = "Well done ! #{guess.capitalize} is a good word !"
        @result[:score] += (guess.size.to_f / 100 * 18 + 10) - time.to_i
        @result[:score] = "You scored #{@result[:score].round(3)} points."
      else
        @result[:message] = "#{guess.capitalize} uses letters not in the grid !"
        @result[:score] = 'But you lost !'
      end
    else
      @result[:message] = "#{guess.capitalize} is not an english word. You lost !"
      @result[:score] = 'But you lost !'
    end
  end
end
