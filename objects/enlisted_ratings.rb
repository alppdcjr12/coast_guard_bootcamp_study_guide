require "csv"
require "open3"

class EnlistedRating
  ENLISTED_RATINGS = CSV.read("resources/enlisted_ratings.csv")

  attr_reader :abbreviation, :rating

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

EnlistedRating::ENLISTED_RATINGS.each do |arr|
  ENLISTED_RATINGS_QUESTIONS << EnlistedRating.new(*arr, type="get_abbreviation")
  ENLISTED_RATINGS_QUESTIONS << EnlistedRating.new(*arr, type="get_rating")
end

LIST_ALL_ENLISTED_RATINGS_QUESTIONS = EnlistedRating::ENLISTED_RATINGS.map do |arr|
  EnlistedRating.new(*arr, type="list_all")
end.reverse