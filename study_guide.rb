require_relative 'config.rb'

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
        @focuses << arg if !@focuses.include?(arg) && ARGV.include?(arg) || ARGV.include?("ONLY_" + arg)
      end
    end
    @include_nonessential = ARGV.include?("INCLUDE_NONESSENTIAL")
    @phonetic_only = ARGV.include?("PHONETIC")
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
    if @phonetic_only
      remove_nonphonetic_questions
      PHONETIC_FOCUS_ARGS.each do |k, v|
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
    @questions.shuffle! unless SPECIAL_FOCUS_ARGS.keys.include?(@focuses[0]) && @focuses.length == 1
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
    continue = true
    input = STDIN.gets.chomp
    while true
      choice = parse_commands(input)
      if choice == "quit"
        return false
      elsif choice == "continue"
        return true
      else
      input = choice
      end
    end
  end

  def parse_commands(input)
    if USER_CHOICE_ARGS["Print instructions"].include?(input)
      input = print_instructions
      return input
    end
    return "quit" if USER_CHOICE_ARGS["Quit program"].include?(input)
    if USER_CHOICE_ARGS["Restart questions from the beginning"].include?(input)
      @questions << @current_question
      @questions << @complete.pop until @complete.empty?
    else
      args = input.split(" ")
      if USER_CHOICE_ARGS["Go back [n] questions"].include?(args[0])
        go_back_n_questions(args[1])
      else
        @complete << @current_question
      end
    end
    return "continue"
  end

  def go_back_n_questions(num)
    num = num.to_i
    @questions << @current_question
    num -= 1
    if num > 0
      num.times { @questions << @complete.pop if !@complete.empty? }
    end
  end

  def print_instructions
    system('cls')
    puts "Instructions:"
    USER_CHOICE_ARGS.each do |k, v|
      appended_n = k.include?("[n]") ? " [n]" : ""
      puts k + ": " + v.join("/") + appended_n
    end
    puts "Press any key to continue."
    choice = STDIN.gets.chomp
    system('cls')
    choice
  end

  def remove_nonphonetic_questions
    @questions.select! do |question|
      if question.is_a?(RatesAndRanksQuestion)
        question.type1 != :abbreviation &&
        question.type2 != :abbreviation &&
        question.type1 != :pay_grade &&
        question.type2 != :pay_grade &&
        PHONETIC_FOCUS_ARGS.values.none? do |question_arr|
          question_arr.none? do |phonetic_question|
              phonetic_question.type1 == question.type1 && phonetic_question.type2 == question.type2
          end
        end
      elsif question.is_a?(EnlistedRatingsQuestion)
        question.type == :get_abbreviation
      else
        true
      end
    end
  end

end

g = StudyGuide.new
g.run
