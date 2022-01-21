require "csv"

class ForceProtectionConditionsQuestion
  FPCONS = CSV.read("resources/force_protection_conditions.csv")

  attr_reader :fp_con, :description, :definition

  def initialize(fp_con, description, definition, type)
    @fp_con = fp_con
    @description = description
    @definition = definition
    if type == "get_description_and_definition"
      @question = "Provide description and definition of #{@fp_con}."
      @answer = "#{@description}\n#{@definition}"
    elsif type == "get_condition_from_description"
      @question = "Which FPCON is described by '#{@description}'?"
      @answer = "#{@fp_con}"  
    elsif type == "get_condition_from_definition"
      @question = "Which FPCON '#{@definition.downcase}'?"
      @answer = "#{@fp_con}"  
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

FORCE_PROTECTION_CONDITIONS_QUESTIONS = []

ForceProtectionConditionsQuestion::FPCONS.each do |con, descr, definition|
  FORCE_PROTECTION_CONDITIONS_QUESTIONS << ForceProtectionConditionsQuestion.new(con, descr, definition, "get_description_and_definition")
  FORCE_PROTECTION_CONDITIONS_QUESTIONS << ForceProtectionConditionsQuestion.new(con, descr, definition, "get_condition_from_description")
  FORCE_PROTECTION_CONDITIONS_QUESTIONS << ForceProtectionConditionsQuestion.new(con, descr, definition, "get_condition_from_definition")
end