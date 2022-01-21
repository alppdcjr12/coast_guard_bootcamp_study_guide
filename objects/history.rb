require "csv"

class HistoryQuestion
  FACTS = CSV.read("resources/history.csv")

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

HISTORY_QUESTIONS = []

HistoryQuestion::FACTS.each do |q, a|
  HISTORY_QUESTIONS << HistoryQuestion.new(q, a)
end