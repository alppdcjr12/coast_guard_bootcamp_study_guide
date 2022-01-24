require "csv"

class UniformsQuestion
  UNIFORMS = CSV.read("resources/nonessential/uniforms.csv").map do |ele1, ele2, regulations_string|
    regulations = regulations_string.split(";").map { |pair_string| pair_string.split("=") }

    [ele1, ele2, regulations]
  end

  attr_reader :name, :description, :regulations

  def initialize(name, description, regulations, type, i=nil)
    @name = name
    @description = description
    @regulations = regulations
    @type = type
    if @type == "get_description_and_regulations"
      @question = "Describe the #{@name}."
      @answer = "#{@description}\n" + @regulations.map { |k, v| "#{k}: #{v}" }.join("\n")
    elsif @type == "get_regulation"
      @question = "What regulations apply for the #{@name} #{@regulations[i][0].downcase}?"
      @answer = "Regulation: #{@regulations[i][1]}"
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

UNIFORMS_QUESTIONS = []

UniformsQuestion::UNIFORMS.each_with_index do |arr, i|
  UNIFORMS_QUESTIONS << UniformsQuestion.new(*arr, "get_description_and_regulations")
  max = UniformsQuestion::UNIFORMS.map { |_, _, regs| regs.length }.max
  (0..max).each do |i|
    begin
      UNIFORMS_QUESTIONS << UniformsQuestion.new(*arr, "get_regulation", i)
    rescue NoMethodError
    end
  end
end