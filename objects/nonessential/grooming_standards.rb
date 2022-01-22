require "csv"

class GroomingStandardsQuestion
  GROOMING_STANDARDS = CSV.read("resources/nonessential/grooming_standards.csv").each_with_object({}) do |row, hash|
    hash[row[0]] ||= []
    hash[row[0]] << [row[1]]
  end

  def initialize(type)
    @type = type
    @question = "Describe #{@type.downcase}."
    @answer = GROOMING_STANDARDS[@type].join("\n")
  end

  def ask
    puts @question
    STDIN.gets
    puts @answer
    STDIN.gets
    system 'cls'
  end

end

GROOMING_STANDARDS_QUESTIONS = []

GroomingStandardsQuestion::GROOMING_STANDARDS.keys.each do |type|
  GROOMING_STANDARDS_QUESTIONS << GroomingStandardsQuestion.new(type)
end