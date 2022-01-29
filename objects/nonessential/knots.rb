require "csv"

class KnotsQuestion
  KNOTS = CSV.read("resources/nonessential/knots.csv")

  attr_reader :knot, :description

  def initialize(knot, description, type)
    @knot = knot
    @description = description
    @type = type
    if @type == "get_description"
      @question = "What is the purpose of a #{@knot.downcase}?"
      @answer = "A #{@knot.downcase} is #{@description.downcase}."
    elsif @type == "get_knot"
      @question = "What knot is #{@description.downcase}?"
      @answer = "#{@knot}"
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

KNOTS_QUESTIONS = []

KnotsQuestion::KNOTS.each do |arr|
  KNOTS_QUESTIONS << KnotsQuestion.new(*arr, "get_description")
  KNOTS_QUESTIONS << KnotsQuestion.new(*arr, "get_knot")
end