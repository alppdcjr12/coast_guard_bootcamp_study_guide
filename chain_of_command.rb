class ChainOfCommand
  attr_reader :title, :person, :type, :reports_to, :below

  PEOPLE = [
    ["Commander in Chief", "The Honorable Joe Biden"],
    ["Secretary of Homeland Security", "The Honorable Alejandro Mayorkas"],
    ["Commandant of the Coast Guard", "Admiral Karl L. Schultz"],
    ["Deputy Commandant for Mission Support", "Vice Admiral Paul Thomas"],
    ["Commander Force Readiness Command", "Rear Admiral M. W. Raymond"],
    ["Commanding Officer TRACEN Cape May", "Captain Sarah Felger"],
    ["Executive Officer", nil],
    ["Training Officer", nil],
    ["Regimental Officer", nil],
    ["Battalion Officer", nil],
    ["Battalion Commander", nil],
    ["Assistant Battalion Commander", nil],
    ["Section Commander", nil],
    ["Lead Company Commander", nil],
    ["Company Commander", nil],
  ]

  def initialize(index, arr, type)
    @title = arr[0]
    @person = arr[1]
    @type = type
    if @type == "chain1"
      @reports_to = index > 0 ? ChainOfCommand.new(index-1, PEOPLE[index-1], "reference") : nil
    elsif @type == "chain2"
      @below = index < PEOPLE.length-1 ? ChainOfCommand.new(index+1, PEOPLE[index+1], "reference") : nil
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
      gets
      if @reports_to
        puts @reports_to.full_name_and_title
      else
        puts "no one"
      end
    elsif @type == "chain2"
      puts "Who is directly below #{full_name_and_title} in the Chain of Command?"
      gets
      if @below
        puts @below.full_name_and_title
      else
        puts "myself"
      end
    elsif @type == "identity1"
      puts "Who is the #{@title}?"
      gets
      puts @person
    elsif @type == "identity2"
      puts "What is #{@person}'s title?"
      gets
      puts @title
    end

    gets
    system 'cls'

  end
end

CHAIN_OF_COMMAND_QUESTIONS = []

ChainOfCommand::PEOPLE.each_with_index do |person_arr, i|
  if i > 0
    CHAIN_OF_COMMAND_QUESTIONS << ChainOfCommand.new(i, person_arr, "chain1")
  end
  if i < ChainOfCommand::PEOPLE.length-1
    CHAIN_OF_COMMAND_QUESTIONS << ChainOfCommand.new(i, person_arr, "chain2")
  end
  if i >= 0 && i <= 5
    CHAIN_OF_COMMAND_QUESTIONS << ChainOfCommand.new(i, person_arr, "identity1")
    CHAIN_OF_COMMAND_QUESTIONS << ChainOfCommand.new(i, person_arr, "identity2")
  end
end