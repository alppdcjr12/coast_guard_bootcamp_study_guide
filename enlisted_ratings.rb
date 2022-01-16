require "csv"

class EnlistedRating
  ENLISTED_RATINGS = CSV.read("resources/enlisted_ratings.csv")

  attr_reader :abbreviation, :rating

  def initialize(abbreviation, rating, type)
    @abbreviation = abbreviation
    @rating = rating
    if type == "get_abbreviation"
      @question = "What is the abbreviation for #{@rating}?"
      @answer = @abbreviation
    elsif type == "get_rating"
      @question = "What rating is abbreviated with #{@abbreviation}?"
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
 
ENLISTED_RATING_QUESTIONS = []

EnlistedRating::ENLISTED_RATINGS.each do |k, v|
  ENLISTED_RATING_QUESTIONS << EnlistedRating.new(k, v, type="get_abbreviation")
  ENLISTED_RATING_QUESTIONS << EnlistedRating.new(k, v, type="get_rating")
end