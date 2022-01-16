require_relative "orders"
require_relative "history"
require_relative "chain_of_command"
require_relative "rates_and_ranks"
require_relative "enlisted_ratings"
require_relative "nautical_terminology"

class StudyGuide

  def initialize
    @questions = []
    only = nil
    focus = nil
    [
      "ONLY_GENERAL_ORDER",
      "ONLY_HISTORY",
      "ONLY_CHAIN_OF_COMMAND",
      "ONLY_RATES_AND_RANKS",
      "ONLY_PHONETIC_RANKS_AND_RANKS",
      "ONLY_ENLISTED_RATING",
      "ONLY_NAUTICAL_TERMINOLOGY"
    ].each do |arg|
      if ARGV.include?(arg)
        only = true
        focus = arg
      end
    end
    if only
      if focus == "ONLY_GENERAL_ORDER"
        @questions += GENERAL_ORDER_QUESTIONS
      elsif focus == "ONLY_HISTORY"
        @questions += HISTORY_QUESTIONS
      elsif focus == "ONLY_CHAIN_OF_COMMAND"
        @questions += CHAIN_OF_COMMAND_QUESTIONS
      elsif focus == "ONLY_RATES_AND_RANKS"
        @questions += RATES_AND_RANKS_QUESTIONS
      elsif focus == "ONLY_PHONETIC_RANKS_AND_RANKS"
        @questions += PHONETIC_RATES_AND_RANKS_QUESTIONS
      elsif focus == "ONLY_ENLISTED_RATING"
        @questions += ENLISTED_RATING_QUESTIONS
      elsif focus == "ONLY_NAUTICAL_TERMINOLOGY"
        @questions += NAUTICAL_TERMINOLOGY_QUESTIONS
      end
    else
      if !ARGV.include?("OMIT_GENERAL_ORDER")
        @questions += GENERAL_ORDER_QUESTIONS
        @questions.shuffle!
      end
      if !ARGV.include?("OMIT_HISTORY")
        @questions += HISTORY_QUESTIONS
        @questions.shuffle!
      end
      if !ARGV.include?("OMIT_CHAIN_OF_COMMAND")
        @questions += CHAIN_OF_COMMAND_QUESTIONS
        @questions.shuffle!
      end
      if !ARGV.include?("OMIT_RATES_AND_RANKS")
        @questions += RATES_AND_RANKS_QUESTIONS
        @questions.shuffle!
      end
      if !ARGV.include?("OMIT_PHONETIC_RATES_AND_RANKS")
        @questions += PHONETIC_RATES_AND_RANKS_QUESTIONS
        @questions.shuffle!
      end
      if !ARGV.include?("OMIT_ENLISTED_RATING")
        @questions += ENLISTED_RATING_QUESTIONS
        @questions.shuffle!
      end
      if !ARGV.include?("OMIT_NAUTICAL_TERMINOLOGY")
        @questions += NAUTICAL_TERMINOLOGY_QUESTIONS
        @questions.shuffle!
      end
    end
    @questions.shuffle!
    @complete = []
    @current_question = nil
  end

  def run
    while !@questions.empty?
      puts "#{@questions.length} questions remaining."
      @current_question = @questions.pop
      @current_question.ask
      next_task = STDIN.gets.chomp
      return true if ["quit", "q"].include?(next_task)
      if ["repeat", "r", "back", "b"].include?(next_task.split(" ")[0])
        num = next_task.split(" ")[1]
        begin
          num = num.to_i
          @questions << @current_question
          num -= 1
          if num > 0
            num.times { @questions << @complete.pop if !@complete.empty? }
          end
        rescue
          @questions << @current_question
        end
      else
        @complete << @current_question
      end

    end
    puts "Questions complete!"
  end
end

g = StudyGuide.new
g.run