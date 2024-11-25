require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('a'..'z').to_a.sample }
  end

  def score
    letters = params[:letters].split("")
    letters_included = params[:word].chars.all? { |char| letters.include?(char) }

    valid_count = params[:word].chars.all? { |char| params[:word].count(char) <= letters.count(char) }

    url = "https://dictionary.lewagon.com/#{params[:word]}"

    user_serialized = URI.parse(url).read
    user = JSON.parse(user_serialized)

    test = user["found"]

    if letters_included && valid_count && test
     @result = "Word correct"
   else
     @result = "Word incorrect"
   end

  end

end
