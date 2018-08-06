require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    a = ("A".."Z").to_a
    b = ("A".."Z").to_a
    @letters = (a + b).sample(10)
  end

  def score
    @attempt = params[:attempt].upcase
    @letters = params[:letters]
    @score = 0

    url = "https://wagon-dictionary.herokuapp.com/" + @attempt
    response_serialized = open(url).read
    response = JSON.parse(response_serialized)
    # looks like {"found"=>true, "word"=>"dog", "length"=>3}
    attempt_letters = @attempt.upcase.split("")
    attempt_letters.each do |attempt_letter|
      if !@letters.include?(attempt_letter)
        @message = "a letter used was not in the group!"
      elsif response["found"]
        @message = "yeah"
        @score = @attempt.length.to_i
      else
        @message = "not an english word"
      end
    end
    cookies[:score] + @score
  end
end




  # def score
  #   @attempt = params[:attempt].upcase
  #   @letters = params[:letters]
  #   @score = 0

  #   url = "https://wagon-dictionary.herokuapp.com/" + @attempt
  #   response_serialized = open(url).read
  #   response = JSON.parse(response_serialized)
  #   # looks like {"found"=>true, "word"=>"dog", "length"=>3}
  #   attempt_letters = @attempt.upcase.split("")
  #   attempt_letters.each do |attempt_letter|
  #     if !@letters.include?(attempt_letter)
  #       @message = "a letter used was not in the group!"
  #     elsif response["found"]
  #       @message = "yeah"
  #       @score = @attempt.length
  #     else
  #       @message = "not an english word"
  #     end
  #   end
  # end

