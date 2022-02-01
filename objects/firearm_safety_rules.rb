class FirearmSafetyRulesQuestion
  
  FIREARM_SAFETY_RULES = [
    "Treat all firearms as if they are loaded.",
    "Always maintain proper muzzle control.",
    "Keep finger off the trigger until on target and ready to shoot.",
    "Know your target and what is beyond it.",
  ]
  
  attr_reader :number, :content, :ordinal

  def initialize(number, content, type)
    if number
      @number = number + 1
      @ordinal = set_ordinal
    end
    @content = content
    @type = type
  end

  def set_ordinal
    suffixes = {1 => "st", 2 => "nd", 3 => "rd"}
    suffix = @number > 3 ? "th" : suffixes[@number]
    "#{@number}#{suffix}"
  end

  def ask
    if @type == "get_one"
      puts "What is the #{ordinal} firearm safety rule?"
      STDIN.gets
      puts @content
    elsif @type == "get_all"
      puts "What are the firearm safety rules?"
      STDIN.gets
      puts FIREARM_SAFETY_RULES.map.with_index { |rule, i| "#{i+1}: #{rule}" }.join("\n")
    end
    STDIN.gets
    system 'cls'
  end

end

FIREARM_SAFETY_RULES_QUESTIONS = FirearmSafetyRulesQuestion::FIREARM_SAFETY_RULES.map.with_index do |rule, i|
  FirearmSafetyRulesQuestion.new(i, rule, type="get_one")
end

FIREARM_SAFETY_RULES_QUESTIONS << FirearmSafetyRulesQuestion.new(nil, nil, type="get_all")