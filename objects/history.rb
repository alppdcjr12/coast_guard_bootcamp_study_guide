require "csv"

class History
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

History::FACTS.each do |q, a|
  HISTORY_QUESTIONS << History.new(q, a)
end