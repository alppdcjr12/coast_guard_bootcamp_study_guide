require_relative "objects/orders"
require_relative "objects/history"
require_relative "objects/chain_of_command"
require_relative "objects/rates_and_ranks"
require_relative "objects/enlisted_ratings"
require_relative "objects/nautical_terminology"
require_relative "objects/force_protection_conditions"
require_relative "objects/roles_and_missions"
require_relative "objects/international_code_of_signals"

require_relative "objects/nonessential/grooming_standards"
require_relative "objects/nonessential/uniforms"
require_relative "objects/nonessential/nonrate_enlisted_evaluation_system"

ESSENTIAL_FOCUS_ARGS = {
  "GENERAL_ORDERS" => GENERAL_ORDERS_QUESTIONS,
  "HISTORY" => HISTORY_QUESTIONS,
  "CHAIN_OF_COMMAND" => CHAIN_OF_COMMAND_QUESTIONS,
  "RATES_AND_RANKS" => RATES_AND_RANKS_QUESTIONS,
  "PHONETIC_RANKS_AND_RANKS" => PHONETIC_RATES_AND_RANKS_QUESTIONS,
  "ENLISTED_RATINGS" => ENLISTED_RATINGS_QUESTIONS,
  "NAUTICAL_TERMINOLOGY" => NAUTICAL_TERMINOLOGY_QUESTIONS,
  "FORCE_PROTECTION_CONDITIONS" => FORCE_PROTECTION_CONDITIONS_QUESTIONS,
  "ROLES_AND_MISSIONS" => ROLES_AND_MISSIONS_QUESTIONS,
  "INTERNATIONAL_CODE_OF_SIGNALS" => INTERNATIONAL_CODE_OF_SIGNALS_QUESTIONS,
}

SPECIAL_FOCUS_ARGS = {
  "LIST_ALL_ENLISTED_RATINGS" => LIST_ALL_ENLISTED_RATINGS_QUESTIONS,
}

NONESSENTIAL_FOCUS_ARGS = {
  "GROOMING_STANDARDS" => GROOMING_STANDARDS_QUESTIONS,
  "UNIFORMS" => UNIFORMS_QUESTIONS,
  "NONRATE_ENLISTED_EVALUATION_SYTEM" => NONRATE_ENLISTED_EVALUATION_SYSTEM_QUESTIONS,
  "NONRATE_EES" => NONRATE_ENLISTED_EVALUATION_SYSTEM_QUESTIONS,
}

FOCUS_ARGS = [ESSENTIAL_FOCUS_ARGS, NONESSENTIAL_FOCUS_ARGS, SPECIAL_FOCUS_ARGS]

USER_CHOICE_ARGS = {
  "Go back [n] questions" => ["repeat", "r", "back", "b"], # i.e. "back [n]""
  "Restart questions from the beginning" => ["restart", "rs", "start_over", "so", "beginning"],
  "Print instructions" => ["instructions", "i"],
  "Quit program" => ["quit", "q"],
}

class StudyGuide

  def initialize
    @questions = []
    @focuses = []
    @complete = []
    @current_question = nil
    @include_nonessential = false

    set_focuses_from_args

    @focuses.empty? ? add_default_questions : add_focus_questions
  end

  def set_focuses_from_args
    FOCUS_ARGS.each do |focus_hash|
      focus_hash.keys.each do |arg|
        @focuses << arg if ARGV.include?(arg) || ARGV.include?("ONLY_" + arg)
      end
    end
    @include_nonessential = ARGV.include?("INCLUDE_NONESSENTIAL")
  end

  def add_default_questions
    ESSENTIAL_FOCUS_ARGS.each do |k, v|
      @questions += v unless ARGV.include?("OMIT_" + k)
    end
    if @include_nonessential
      NONESSENTIAL_FOCUS_ARGS.each do |k, v|
        @questions += v unless ARGV.include?("OMIT_" + k)
      end
    end
    @questions.shuffle!
  end

  def add_focus_questions
    FOCUS_ARGS.each do |focus_hash|
      @focuses.each do |focus|
        questions = focus_hash[focus]
        @questions += questions if questions
      end
    end
    @questions.shuffle! unless @focuses[0] == "LIST_ALL_ENLISTED_RATINGS" && @focuses.length == 1
  end

  def run
    while !@questions.empty?
      s = @questions.length > 1 ? "s" : ""
      puts "#{@questions.length} question#{s} remaining."
      @current_question = @questions.pop
      @current_question.ask
      if !get_user_choice
        return true
      end
    end
    puts "Questions complete!"
  end
  
  def get_user_choice
    input = STDIN.gets.chomp
    return false if USER_CHOICE_ARGS["Quit program"].include?(input)
    print_instructions if USER_CHOICE_ARGS["Print instructions"].include?(input)
    if USER_CHOICE_ARGS["Restart questions from the beginning"].include?(input)
      @questions << @current_question
      @questions << @complete.pop until @complete.empty?
    else
      go_back_n_questions(input)
    end
  end

  def go_back_n_questions(input)
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
