require "csv"

class MiscellaneousQuestion
  FACTS = CSV.read("resources/miscellaneous.csv")

  attr_reader :question, :answer

  def initialize(question, answer)
    @question = question
    @answer = answer
  end

  def ask
    puts @question
    STDIN.gets
    puts @answer
    STDIN.gets
    system 'cls'
  end

end

MISCELLANEOUS_QUESTIONS = []

MiscellaneousQuestion::FACTS.each do |q, a|
  MISCELLANEOUS_QUESTIONS << MiscellaneousQuestion.new(q, a)
end