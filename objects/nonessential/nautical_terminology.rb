require "csv"

class NauticalTerminologyQuestion
  NAUTICAL_TERMINOLOGY = CSV.read("resources/nonessential/nautical_terminology.csv")

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
    elsif type == "words_in_order"
      @question = "Next?"
      @answer = @term
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
NAUTICAL_TERMINOLOGY_WORDS_IN_ORDER = []

NauticalTerminologyQuestion::NAUTICAL_TERMINOLOGY.each do |k, v|
  NAUTICAL_TERMINOLOGY_QUESTIONS << NauticalTerminologyQuestion.new(k, v, type="get_term")
  NAUTICAL_TERMINOLOGY_QUESTIONS << NauticalTerminologyQuestion.new(k, v, type="get_meaning")
  NAUTICAL_TERMINOLOGY_WORDS_IN_ORDER << NauticalTerminologyQuestion.new(k, v, type="words_in_order")
end

NAUTICAL_TERMINOLOGY_WORDS_IN_ORDER.reverse!