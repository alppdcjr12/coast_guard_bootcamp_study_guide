require_relative "phonetic_alphabet.rb"
require "csv"

class RatesAndRanksQuestion
  RATES_AND_RANKS = CSV.read("resources/rates_and_ranks.csv")

  attr_reader :pay_grade, :title, :abbreviation, :collar_device, :shoulder_insignia, :lacing, :type1, :type2

  def initialize(pay_grade, title, abbreviation, collar_device, shoulder_insignia, alt_shoulder_insignia, lacing, type1, type2, phonetic=false)
    @pay_grade = pay_grade
    @title = title
    @abbreviation = abbreviation
    @collar_device = collar_device
    @shoulder_insignia = shoulder_insignia + " OR " + alt_shoulder_insignia
    @lacing = lacing
    @type1 = type1
    @type2 = type2
    @phonetic = phonetic
  end

  def ask
    given = self.send(@type2)
    if @phonetic
      if @type2 == :pay_grade || (@type2 == :abbreviation && given[0] == "W")
        phonetic = given.split("").map.with_index { |c, i| i == 0 ? replace_phonetic(c) : c }.join("")
        puts "What is the #{@type1} for the #{@type2} #{phonetic}?".gsub("_", " ")
      else
        puts "What is the #{@type1} for the #{@type2} #{replace_phonetic(given)}?".gsub("_", " ")
      end
    else
      puts "What is the #{@type1} for the #{@type2} #{given}?".gsub("_", " ")
    end
    STDIN.gets
    answer = self.send(@type1)
    answer += " (#{@title})" if @type1 != :title && @type2 != :title
    puts answer
    STDIN.gets
    system 'cls'
  end

end

RATES_AND_RANKS_QUESTIONS = []

RatesAndRanksQuestion::RATES_AND_RANKS.each_with_index do |arr, i|
  if i < 9 && i > 11
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :title, :pay_grade)
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :pay_grade, :collar_device)
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :abbreviation, :collar_device)
    if 1 < 22
      RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :abbreviation, :pay_grade)
    end
  end
  if 1 < 22
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :pay_grade, :abbreviation)
  end
  if i > 2 && i < RatesAndRanksQuestion::RATES_AND_RANKS.length
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :collar_device, :pay_grade)
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :collar_device, :title)
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :collar_device, :shoulder_insignia)
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :collar_device, :abbreviation)
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :title, :collar_device)
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :shoulder_insignia, :collar_device)
  end
  if i > 11 && i < 22
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :lacing, :collar_device)
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :lacing, :pay_grade)
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :lacing, :title)
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :lacing, :shoulder_insignia)
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :lacing, :abbreviation)
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :pay_grade, :lacing)
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :shoulder_insignia, :lacing)
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :title, :lacing)
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :collar_device, :lacing)
    RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :abbreviation, :lacing)
  end

  RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :shoulder_insignia, :pay_grade)
  RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :pay_grade, :title)
  RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :shoulder_insignia, :title)
  RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :pay_grade, :shoulder_insignia)
  RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :abbreviation, :shoulder_insignia)
  RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :title, :shoulder_insignia)
  RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :shoulder_insignia, :abbreviation)
end

PHONETIC_RATES_AND_RANKS_QUESTIONS = []

RatesAndRanksQuestion::RATES_AND_RANKS.each_with_index do |arr, i|
  if i < 9 && i > 11
    PHONETIC_RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :title, :pay_grade, phonetic=true)
    if 1 < 22
      PHONETIC_RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :abbreviation, :pay_grade, phonetic=true)
    end
  end
  if 1 < 22
    PHONETIC_RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :pay_grade, :abbreviation, phonetic=true)
  end
  if i > 2 && i < RatesAndRanksQuestion::RATES_AND_RANKS.length
    PHONETIC_RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :collar_device, :pay_grade, phonetic=true)
    PHONETIC_RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :collar_device, :abbreviation, phonetic=true)
  end
  if i > 11 && i < 22
    PHONETIC_RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :lacing, :pay_grade, phonetic=true)
    PHONETIC_RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :lacing, :abbreviation, phonetic=true)
  end

  PHONETIC_RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :shoulder_insignia, :pay_grade, phonetic=true)
  PHONETIC_RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :shoulder_insignia, :abbreviation, phonetic=true)
  PHONETIC_RATES_AND_RANKS_QUESTIONS << RatesAndRanksQuestion.new(*arr, :title, :abbreviation, phonetic=true)
end