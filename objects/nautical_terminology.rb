require "csv"

class NauticalTerminologyQuestion
  NAUTICAL_TERMINOLOGY = CSV.read("resources/nautical_terminology.csv")

  attr_reader :term, :meaning

  def initialize(term, meaning, type)
    @term = term
    @meaning = meaning
    if type == "get_term"
      @question = "What is the military/nautical term for \"#{@meaning}\"?"
      @answer = @term
    elsif type == "get_meaning"
      @question = "What does \"#{@term}\" mean in military/nautical terminology?"
      @answer = @meaning
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
 
NAUTICAL_TERMINOLOGY_QUESTIONS = []

NauticalTerminologyQuestion::NAUTICAL_TERMINOLOGY.each do |k, v|
  NAUTICAL_TERMINOLOGY_QUESTIONS << NauticalTerminologyQuestion.new(k, v, type="get_term")
  NAUTICAL_TERMINOLOGY_QUESTIONS << NauticalTerminologyQuestion.new(k, v, type="get_meaning")
end