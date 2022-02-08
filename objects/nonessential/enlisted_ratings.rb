require "csv"
require "open3"
require_relative "../phonetic_alphabet.rb"

class EnlistedRatingsQuestion
  ENLISTED_RATINGS = CSV.read("resources/nonessential/enlisted_ratings.csv")

  attr_reader :abbreviation, :rating, :type

  def initialize(abbreviation, rating, type)
    @abbreviation = abbreviation
    @rating = rating
    @img_path = "resources/rating_images/#{abbreviation.downcase}.png"
    @type = type
    if type == "get_abbreviation"
      @question = "What is the abbreviation for #{@rating}?"
      @answer = @abbreviation
    elsif type == "get_rating"
      @question = "What rating is abbreviated with #{@abbreviation}?"
      @answer = @rating
    elsif type == "list_all"
      @question = "Next enlisted rating?"
      @answer = "#{@rating} (#{@abbreviation})"
    elsif type == "phonetic"
      @question = "What rating does #{replace_phonetic(@abbreviation)} stand for?"
      @answer = @rating
    end
  end

  def ask
    puts @question
    STDIN.gets
    puts @answer
    STDIN.gets
    system 'cls'
  end

end
 
ENLISTED_RATINGS_QUESTIONS = []

EnlistedRatingsQuestion::ENLISTED_RATINGS.each do |arr|
  ENLISTED_RATINGS_QUESTIONS << EnlistedRatingsQuestion.new(*arr, type="get_abbreviation")
  ENLISTED_RATINGS_QUESTIONS << EnlistedRatingsQuestion.new(*arr, type="get_rating")
end

LIST_ALL_ENLISTED_RATINGS_QUESTIONS = EnlistedRatingsQuestion::ENLISTED_RATINGS.map do |arr|
  EnlistedRatingsQuestion.new(*arr, type="list_all")
end.reverse

PHONETIC_ENLISTED_RATINGS_QUESTIONS = EnlistedRatingsQuestion::ENLISTED_RATINGS.map do |arr|
  EnlistedRatingsQuestion.new(*arr, type="phonetic")
end