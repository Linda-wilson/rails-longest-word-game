require 'open-uri'
require 'json'
class GamesController < ApplicationController

  def new
    @letters = [*'A'..'Z'].sample(10)
  end

  def score
    @answer = params[:answer].upcase.chars
    if !(@answer.all? { |ans| @answer.count(ans) <= params[:letters].chars.count(ans) })
      @result = "#{params[:answer]} does not belong to #{params[:letters]}"
    else
      response = URI.parse("https://wagon-dictionary.herokuapp.com/#{params[:answer]}")
      json = JSON.parse(response.read)
      json["found"] == true ? @result = "Congratulations! #{params[:answer]} seems to be an English word" : @result = "#{params[:answer]} does not seems to be an english word"
    end
  end
end
