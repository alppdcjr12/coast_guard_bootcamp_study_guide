require "csv"

class CoreValesQuestion
  CORE_VALUES = CSV.read("resources/core_values.csv")

  attr_reader :core_value, :definition, :type

  def initialize(type="get_all_values", core_value=nil, definition=nil)
    @core_value = core_value
    @definition = definition
    if type == "get_all_values"
      @question = "What are the Coast Guard Core Values?"
      @answer = CORE_VALUES.map { |arr| arr[0] }.join(", ")
    elsif type == "get_definition"
      @question = "What is the definition of the Coast Guard Core Value '#{@core_value}'?"
      @answer = @definition
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

ESSENTIAL_CORE_VALUES_QUESTION = [CoreValesQuestion.new("get_all_values")]

NONESSENTIAL_CORE_VALUES_QUESTIONS = []

CoreValesQuestion::CORE_VALUES.each do |core_value, definition|
  NONESSENTIAL_CORE_VALUES_QUESTIONS << CoreValesQuestion.new("get_definition", core_value=core_value, definition=definition)
end