require_relative "orders"
require_relative "history"
require_relative "chain_of_command"
require_relative "rates_and_ranks"

class Game

  def initialize
    @questions = GENERAL_ORDER_QUESTIONS
    @questions.shuffle!
    @questions += HISTORY_QUESTIONS
    @questions.shuffle!
    @questions += CHAIN_OF_COMMAND_QUESTIONS
    @questions.shuffle!
    @questions += RATES_AND_RANKS_QUESTIONS
    @questions.shuffle!
    @complete = []
    @current_question = nil
  end

  def play
    while !@questions.empty?
      puts "#{@questions.length} questions remaining."
      @current_question = @questions.pop
      @current_question.ask
      next_task = gets.chomp
      return true if ["quit", "q"].include?(next_task)
      @complete << @current_question

    end
  end
end

g = Game.new
g.play