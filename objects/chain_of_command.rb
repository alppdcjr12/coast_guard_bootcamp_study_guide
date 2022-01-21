require "csv"

class ChainOfCommandQuestion
  attr_reader :title, :person, :type, :reports_to, :below

  PEOPLE = CSV.read("resources/chain_of_command.csv")

  def initialize(index, arr, type)
    @title = arr[0]
    @person = arr[1]
    @type = type
    if @type == "chain1"
      @reports_to = index > 0 ? ChainOfCommandQuestion.new(index-1, PEOPLE[index-1], "reference") : nil
    elsif @type == "chain2"
      @below = index < PEOPLE.length-1 ? ChainOfCommandQuestion.new(index+1, PEOPLE[index+1], "reference") : nil
    end
  end

  def full_name_and_title
    if @person
      "#{@person}, #{@title}"
    else
      "the #{@title}"
    end
  end

  def ask
    if @type == "chain1"
      puts "Who does #{full_name_and_title} report to?"
      STDIN.gets
      if @reports_to
        puts @reports_to.full_name_and_title
      else
        puts "no one"
      end
    elsif @type == "chain2"
      puts "Who is directly below #{full_name_and_title} in the Chain of Command?"
      STDIN.gets
      if @below
        puts @below.full_name_and_title
      else
        puts "myself"
      end
    elsif @type == "identity1"
      puts "Who is the #{@title}?"
      STDIN.gets
      puts @person
    elsif @type == "identity2"
      puts "What is #{@person}'s title?"
      STDIN.gets
      puts @title
    end

    STDIN.gets
    system 'cls'

  end
end

CHAIN_OF_COMMAND_QUESTIONS = []

ChainOfCommandQuestion::PEOPLE.each_with_index do |person_arr, i|
  if i > 0
    CHAIN_OF_COMMAND_QUESTIONS << ChainOfCommandQuestion.new(i, person_arr, "chain1")
  end
  if i < ChainOfCommandQuestion::PEOPLE.length-1
    CHAIN_OF_COMMAND_QUESTIONS << ChainOfCommandQuestion.new(i, person_arr, "chain2")
  end
  if i >= 0 && i <= 5
    CHAIN_OF_COMMAND_QUESTIONS << ChainOfCommandQuestion.new(i, person_arr, "identity1")
    CHAIN_OF_COMMAND_QUESTIONS << ChainOfCommandQuestion.new(i, person_arr, "identity2")
  end
end