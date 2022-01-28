require "csv"

class InternationalCodeOfSignalsQuestion
  FLAGS = CSV.read("resources/international_code_of_signals.csv")

  attr_reader :flag, :meaning

  def initialize(flag, meaning, type)
    @flag = flag
    @meaning = meaning
    if type == "get_meaning"
      @question = "What is the meaning of the '#{@flag.gsub("_", " ")}' flag in the International Code of Signals?"
      @answer = @meaning
    elsif type == "get_flag"
      @question = "Which flag has the meaning of '#{@meaning}' in the International Code of Signals?"
      @answer = @flag
    end
  end

  def ask
    puts @question
    STDIN.gets
    puts @answer
    STDIN.gets
    system 'cls'
  end

end

INTERNATIONAL_CODE_OF_SIGNALS_QUESTIONS = []

FLAG_MEANINGS_IN_ORDER = []

InternationalCodeOfSignalsQuestion::FLAGS.each do |flag, meaning|
  INTERNATIONAL_CODE_OF_SIGNALS_QUESTIONS << InternationalCodeOfSignalsQuestion.new(flag, meaning, "get_meaning")
  INTERNATIONAL_CODE_OF_SIGNALS_QUESTIONS << InternationalCodeOfSignalsQuestion.new(flag, meaning, "get_flag")
  FLAG_MEANINGS_IN_ORDER << InternationalCodeOfSignalsQuestion.new(flag, meaning, "get_meaning")
end

FLAG_MEANINGS_IN_ORDER.reverse!