require "csv"
require "open3"

class RolesAndMissionsQuestion
  ROLES_AND_MISSIONS = CSV.read("resources/roles_and_missions.csv")

  attr_reader :role, :description, :missions, :type

  def initialize(role, description, missions, type, i=nil)
    @role = role    
    @description = description
    @missions_string = missions
    @missions = missions.split("; ")
    @type = type
    if type == "get_description_and_missions"
      @question = "State the description and mission categories that fall under the Coast Guard's role of #{@role}."
      @answer = "Description: #{@description}\nMissions: #{@missions_string}"
    elsif type == "get_role"
      @question = "A mission in the #{@missions[i]} category falls into which of the Coast Guard's roles?"
      @answer = "#{@role}"
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
 
ROLES_AND_MISSIONS_QUESTIONS = []

RolesAndMissionsQuestion::ROLES_AND_MISSIONS.each do |arr|
  ROLES_AND_MISSIONS_QUESTIONS << RolesAndMissionsQuestion.new(*arr, type="get_description_and_missions")
  (0..4).each do |i|
    if i < arr[2].split("; ").length
      ROLES_AND_MISSIONS_QUESTIONS << RolesAndMissionsQuestion.new(*arr, type="get_role", i)
    end
  end
end