require_relative "orders"
require_relative "history"
require_relative "chain_of_command"
require_relative "rates_and_ranks"

class Game

  def initialize
    @questions = GENERAL_ORDER_QUESTIONS + HISTORY_QUESTIONS + CHAIN_OF_COMMAND_QUESTIONS + RATES_AND_RANKS_QUESTIONS
    @questions += GENERAL_ORDER_QUESTIONS + HISTORY_QUESTIONS + CHAIN_OF_COMMAND_QUESTIONS
    @questions += GENERAL_ORDER_QUESTIONS + HISTORY_QUESTIONS + CHAIN_OF_COMMAND_QUESTIONS
    @questions += GENERAL_ORDER_QUESTIONS + HISTORY_QUESTIONS + CHAIN_OF_COMMAND_QUESTIONS
    @questions += GENERAL_ORDER_QUESTIONS + HISTORY_QUESTIONS + CHAIN_OF_COMMAND_QUESTIONS
    @complete = []
    @current_question
  end

  def play
    @questions.shuffle!
    while !@questions.empty?
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