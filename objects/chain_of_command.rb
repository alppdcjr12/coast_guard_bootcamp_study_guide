require "csv"

class ChainOfCommandQuestion
  attr_reader :title, :person, :type, :reports_to, :below, :question

  PEOPLE = CSV.read("resources/chain_of_command.csv")

  def initialize(index, arr, type)
    @title = arr[0]
    @person = arr[1]
    @type = type
    if @type == "get_superior"
      @reports_to = index > 0 ? ChainOfCommandQuestion.new(index-1, PEOPLE[index-1], "reference") : nil
    elsif @type == "get_subordinate"
      @below = index < PEOPLE.length-1 ? ChainOfCommandQuestion.new(index+1, PEOPLE[index+1], "reference") : nil
    end
    set_q_and_a
  end

  def set_q_and_a
    if @type == "get_superior"
      @question = "Who does #{full_name_and_title} report to?"
      if @reports_to
        @answer = @reports_to.full_name_and_title
      else
        @answer = "no one"
      end
    elsif @type == "get_subordinate"
      @question = "Who is directly below #{full_name_or_title} in the Chain of Command?"
      if @below
        @answer = @below.full_name_and_title
      else
        @answer = "myself"
      end
    elsif @type == "get_person_with_title"
      @question = "Who is the #{@title}?"
      @answer = @person
    elsif @type == "get_title_of_person"
      @question = "What is #{@person}'s title?"
      @answer = @title
    end
  end

  def full_name_and_title
    if @person
      @person.include?(@title) ? "#{@person}" : "#{@person}, #{@title}"
    else
      "the #{@title}"
    end
  end
  
  def full_name_or_title
    @person ? @person : "the #{@title}"
  end

  def ask
    puts @question
    STDIN.gets
    puts @answer
    STDIN.gets
    system 'cls'
  end
end

CHAIN_OF_COMMAND_QUESTIONS = []

ChainOfCommandQuestion::PEOPLE.each_with_index do |person_arr, i|
  if i > 0
    CHAIN_OF_COMMAND_QUESTIONS << ChainOfCommandQuestion.new(i, person_arr, "get_superior")
  end
  if i < ChainOfCommandQuestion::PEOPLE.length-1
    CHAIN_OF_COMMAND_QUESTIONS << ChainOfCommandQuestion.new(i, person_arr, "get_subordinate")
  end
  if person_arr.length > 1 && person_arr[1] != nil
    CHAIN_OF_COMMAND_QUESTIONS << ChainOfCommandQuestion.new(i, person_arr, "get_person_with_title")
    CHAIN_OF_COMMAND_QUESTIONS << ChainOfCommandQuestion.new(i, person_arr, "get_title_of_person")
  end
end