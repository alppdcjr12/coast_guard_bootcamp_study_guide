require "csv"

class NonrateEnlistedEvaluationQuestion
  NONRATE_EER_FACTS = CSV.read('resources/nonessential/nonrate_eer.csv')

  attr_reader :question, :answer

  def initialize(question, answer)
    @question = question
    @answer = answer
  end

  def ask
    puts "What is the content of the #{@question} in the Non-rate Enlisted Evaluation System?"
    STDIN.gets
    puts @answer
    STDIN.gets
    system 'cls'
  end

end
 
NONRATE_ENLISTED_EVALUATION_SYSTEM_QUESTIONS = []

NonrateEnlistedEvaluationQuestion::NONRATE_EER_FACTS.each do |arr|
  NONRATE_ENLISTED_EVALUATION_SYSTEM_QUESTIONS << NonrateEnlistedEvaluationQuestion.new(*arr)
end