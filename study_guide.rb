require_relative "objects/orders"
require_relative "objects/history"
require_relative "objects/chain_of_command"
require_relative "objects/rates_and_ranks"
require_relative "objects/enlisted_ratings"
require_relative "objects/nautical_terminology"
require_relative "objects/force_protection_conditions"

FOCUS_ARGS = {
  "GENERAL_ORDERS" => GENERAL_ORDERS_QUESTIONS,
  "HISTORY" => HISTORY_QUESTIONS,
  "CHAIN_OF_COMMAND" => CHAIN_OF_COMMAND_QUESTIONS,
  "RATES_AND_RANKS" => RATES_AND_RANKS_QUESTIONS,
  "PHONETIC_RANKS_AND_RANKS" => PHONETIC_RATES_AND_RANKS_QUESTIONS,
  "ENLISTED_RATINGS" => ENLISTED_RATINGS_QUESTIONS,
  "NAUTICAL_TERMINOLOGY" => NAUTICAL_TERMINOLOGY_QUESTIONS,
  "FORCE_PROTECTION_CONDITIONS" => FORCE_PROTECTION_CONDITIONS_QUESTIONS,
}

SPECIAL_FOCUS_ARGS = {
  "LIST_ALL_ENLISTED_RATINGS" => LIST_ALL_ENLISTED_RATINGS_QUESTIONS,
}

USER_CHOICE_ARGS = {
  "Go back [n] questions" => ["repeat", "r", "back", "b"],
  "Restart questions from the beginning" => ["restart", "rs", "start_over", "so", "beginning", "b"],
  "Print instructions" => ["instructions", "i"],
  "Quit program" => ["quit", "q"],
}

class StudyGuide

  def initialize
    @questions = []
    focuses = []
    FOCUS_ARGS.keys.each do |arg|
      focuses << arg if ARGV.include?(arg) || ARGV.include?("ONLY_" + arg)
    end
    SPECIAL_FOCUS_ARGS.keys.each do |arg|
      focuses << arg if ARGV.include?(arg) || ARGV.include?("ONLY_" + arg)
    end
    if focuses.empty?
      FOCUS_ARGS.each do |k, v|
        if !ARGV.include?("OMIT_" + k)
          @questions += v
          @questions.shuffle!
        end
      end
    else
      focuses.each do |focus|
        begin
          @questions += FOCUS_ARGS[focus]
        rescue TypeError
          @questions += SPECIAL_FOCUS_ARGS[focus]
        end
      end
      @questions.shuffle! unless focuses[0] == "LIST_ALL_ENLISTED_RATINGS" && focuses.length == 1
    end
    @complete = []
    @current_question = nil
  end

  def run
    while !@questions.empty?
      puts "#{@questions.length} questions remaining."
      @current_question = @questions.pop
      @current_question.ask
      get_user_choice
    end
    puts "Questions complete!"
  end
  
  def get_user_choice
    input = STDIN.gets.chomp
    return true if USER_CHOICE_ARGS["Quit program"].include?(input)
    print_instructions if USER_CHOICE_ARGS["Print instructions"].include?(input)
    if USER_CHOICE_ARGS["Restart questions from the beginning"].include?(input)
      @questions << @current_question
      @questions << @complete.pop until @complete.empty?
    else
      args = input.split(" ")
      if USER_CHOICE_ARGS["Go back [n] questions"].include?(args[0])
        num = args[1]
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
  end

  def print_instructions
    system('cls')
    puts "Instructions:"
    USER_CHOICE_ARGS.each do |k, v|
      appended_n = k.include?("[n]") ? " [n]" : ""
      puts k + ": " + v.join("/") + appended_n
    end
  end

end

g = StudyGuide.new
g.run
