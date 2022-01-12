class RateRank
  RATES_AND_RANKS = [
    ["E-1", "Seaman Recruit", "SR", nil, "Zero one white stripe", "Zero one white stripe on a field of blue", nil],
    ["E-2", "Seaman Apprentice", "SA", nil, "Zero two white stripes", "Zero two white stripes on a field of blue", nil],
    ["E-3", "Seaman", "SN", nil, "Zero three white stripes", "Zero three white stripes on a field of blue", nil],
    ["E-4", "Petty Officer Third Class", "PO3", "Zero one gold chevron", "Zero one red chevron", "Zero one red chevron below zero one white rating insignia below zero one white crow on a field of blue", nil],
    ["E-5", "Petty Officer Second Class", "PO2", "Zero two gold chevrons", "Zero two red chevrons", "Zero two red chevrons below zero one white rating insignia below zero one white crow on a field of blue", nil],
    ["E-6", "Petty Officer First Class", "PO1", "Zero three gold chevrons", "Zero three red chevrons", "Zero three red chevrons below zero one white rating insignia below zero one white crow on a field of blue", nil],
    ["E-7", "Chief Petty Officer", "CPO", "Zero one gold anchor", "Zero three gold chevrons below zero one gold rocker", "Zero three gold chevrons below zero one white rating insignia below zero one gold rocker below zero one white crow on a field of blue", nil],
    ["E-8", "Senior Chief Petty Officer", "SCPO", "Zero one gold anchor below zero one silver star", "Zero three gold chevrons below zero one gold rocker below zero one silver star", "Zero three gold chevrons below zero one white rating insignia below zero one gold rocker below zero one white crow below zero one silver star on a field of blue", nil],
    ["E-9", "Master Chief Petty Officer", "MCPO", "Zero one gold anchor below zero two silver stars", "Zero three gold chevrons below zero one gold rocker below zero two silver stars", "Zero three gold chevrons below zero one white rating insignia below zero one gold rocker below zero one white crow below zero two silver stars on a field of blue", nil],
    ["E-9 CMC", "Command Master Chief Petty Officer", "CMC", "Zero one gold anchor below zero two silver stars", "Zero three gold chevrons below zero one gold rocker below zero two silver stars", "Zero three gold chevrons below zero one silver shield below zero one gold rocker below zero one white crow below zero two silver stars on a field of blue", nil],
    ["E-9 MCPOCGR", "Master Chief Petty Officer of the Coast Guard Reserve", "MCPOCGR", "Zero one gold anchor below zero two silver stars", "Zero three gold chevrons below zero one gold rocker below zero two gold stars", "Zero three gold chevrons below zero one gold shield below zero one gold rocker below zero one white crow below zero two gold stars on a field of blue", nil],
    ["E-9 MCPOCG", "Master Chief Petty Officer of the Coast Guard", "MCPOCG", "Zero one gold anchor below zero three silver stars", "Zero three gold chevrons below zero one gold rocker below zero three gold stars", "Zero three gold chevrons below zero one gold shield below zero one gold rocker below zero one white crow below zero three gold stars on a field of blue", nil],
    ["O-1", "Ensign", "ENS", "Zero one gold bar", "Zero one half-inch gold band", "Zero one half-inch gold band below zero one gold shield on a field of blue", "Zero one half-inch gold band"],
    ["O-2", "Lieutenant Junior Grade", "LTJG", "Zero one silver bar", "Zero one half-inch gold band below zero one quarter-inch gold band", "Zero one half-inch gold band below zero one quarter-inch gold band below zero one gold shield on a field of blue", "Zero one half-inch gold band below zero one quarter-inch gold band"],
    ["O-3", "Lieutenant", "LT", "Zero two silver bars", "Zero two half-inch gold bands", "Zero two half-inch gold bands below zero one gold shield on a field of blue", "Zero two half-inch gold bands"],
    ["O-4", "Lieutenant Commander", "LCDR", "Zero one gold oak leaf", "Zero one half-inch gold band below zero one quarter-inch gold band below another zero one half-inch gold band", "Zero one half-inch gold band below zero one quarter-inch gold band below another zero one half-inch gold band below zero one gold shield on a field of blue", "Zero one half-inch gold band below zero one quarter-inch gold band below another zero one half-inch gold band"],
    ["O-5", "Commander", "CDR", "Zero one silver oak leaf", "Zero three half-inch gold bands", "Zero three half-inch gold bands below zero one gold shield on a field of blue", "Zero three half-inch gold bands"],
    ["O-6", "Captain", "CAPT", "Zero one silver eagle", "Zero four half-inch gold bands", "Zero four half-inch gold bands below zero one gold shield on a field of blue", "Zero four half-inch gold bands"],
    ["O-7", "Rear Admiral (lower half)", "RDML", "Zero one silver star", "Zero one silver star", "Zero one silver star below zero one anchor behind zero one shield on a field of gold", "Zero one two-inch gold band"],
    ["O-8", "Rear Admiral (upper half)", "RADM", "Zero two silver stars", "Zero two silver stars", "Zero two silver stars below zero one anchor behind zero one shield on a field of gold", "Zero one two-inch gold band below zero one half-inch gold band"],
    ["O-9", "Vice Admiral", "VADM", "Zero three silver stars", "Zero three silver stars", "Zero three silver stars below zero one anchor behind zero one shield on a field of gold", "Zero one two-inch gold band below zero two half-inch gold bands"],
    ["O-10", "Admiral", "ADM", "Zero four silver stars", "Zero four silver stars", "Zero four silver stars below zero one anchor behind zero one shield on a field of gold", "Zero one two-inch gold band below zero three half-inch gold bands"],
  ]

  attr_reader :pay_grade, :title, :abbreviation, :collar_device, :shoulder_insignia, :lacing, :type1, :type2

  def initialize(pay_grade, title, abbreviation, collar_device, shoulder_insignia, alt_shoulder_insignia, lacing, type1, type2)
    @pay_grade = pay_grade
    @title = title
    @abbreviation = abbreviation
    @collar_device = collar_device
    @shoulder_insignia = shoulder_insignia + " OR " + alt_shoulder_insignia
    @lacing = lacing
    @type1 = type1
    @type2 = type2
  end

  def ask
    question = "What #{@type1} corresponds to the following #{@type2}?"
    puts question.to_symbol.to_s.sub("_", " ")
    puts self.send(@type2)
    gets
    puts self.send(@type1)
    gets
    system 'cls'
  end
end

RATES_AND_RANKS_QUESTIONS = []

RateRank::RATES_AND_RANKS.each_with_index do |arr, i|
  if i > 2 && i < RateRank::RATES_AND_RANKS.length
    RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :collar_device, :pay_grade)
    RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :collar_device, :title)
    RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :collar_device, :shoulder_insignia)
    RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :collar_device, :abbreviation)
    RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :pay_grade, :collar_device)
    RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :abbreviation, :collar_device)
    RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :title, :collar_device)
    RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :shoulder_insignia, :collar_device)
  end
  if i > 11 && i < RateRank::RATES_AND_RANKS.length
    RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :lacing, :collar_device)
  end

  RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :title, :pay_grade)
  RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :abbreviation, :pay_grade)
  RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :shoulder_insignia, :pay_grade)
  if i > 11 && i < RateRank::RATES_AND_RANKS.length
    RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :lacing, :pay_grade)
  end
  RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :pay_grade, :title)
  RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :abbreviation, :title)
  RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :shoulder_insignia, :title)
  if i > 11 && i < RateRank::RATES_AND_RANKS.length
    RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :lacing, :title)
  end
  RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :pay_grade, :shoulder_insignia)
  RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :abbreviation, :shoulder_insignia)
  RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :title, :shoulder_insignia)
  if i > 11 && i < RateRank::RATES_AND_RANKS.length
    RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :lacing, :shoulder_insignia)
  end
  RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :pay_grade, :abbreviation)
  RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :shoulder_insignia, :abbreviation)
  RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :title, :abbreviation)
  if i > 11 && i < RateRank::RATES_AND_RANKS.length
    RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :lacing, :abbreviation)
  end
  if i > 11 && i < RateRank::RATES_AND_RANKS.length
    RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :pay_grade, :lacing)
    RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :shoulder_insignia, :lacing)
    RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :title, :lacing)
    RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :collar_device, :lacing)
    RATES_AND_RANKS_QUESTIONS << RateRank.new(*arr, :abbreviation, :lacing)
  end
end