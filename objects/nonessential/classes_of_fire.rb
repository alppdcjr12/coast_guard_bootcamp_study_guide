require_relative "../phonetic_alphabet.rb"
require "csv"

class ClassOfFireQuestion
  CLASSES_OF_FIRE = CSV.read("resources/nonessential/classes_of_fire.csv")

  attr_reader :fire_class, :symbol, :fuel, :smoke_color, :extinguishing_options, :type1, :type2

  def initialize(fire_class, symbol, fuel, smoke_color, extinguishing_options, type1, type2, display_class=false)
    @fire_class = fire_class
    @symbol = symbol
    @fuel = fuel
    @smoke_color = smoke_color
    @extinguishing_options = extinguishing_options
    @type1 = type1
    @type2 = type2
    @display_class = display_class
  end

  def ask
    given = self.send(@type2).downcase
    puts "Name the #{@type1} for the #{@type2} of '#{given}'.".gsub("_", " ")
    STDIN.gets
    answer = self.send(@type1)
    answer += " (#{@fire_class}) class fire" if @display_class
    puts answer
    STDIN.gets
    system 'cls'
  end

end

CLASSES_OF_FIRE_QUESTIONS = []

ClassOfFireQuestion::CLASSES_OF_FIRE.each do |arr|
  CLASSES_OF_FIRE_QUESTIONS << ClassOfFireQuestion.new(*arr, :symbol, :fire_class)
  CLASSES_OF_FIRE_QUESTIONS << ClassOfFireQuestion.new(*arr, :fuel, :fire_class)
  CLASSES_OF_FIRE_QUESTIONS << ClassOfFireQuestion.new(*arr, :smoke_color, :fire_class)
  CLASSES_OF_FIRE_QUESTIONS << ClassOfFireQuestion.new(*arr, :extinguishing_options, :fire_class)
  CLASSES_OF_FIRE_QUESTIONS << ClassOfFireQuestion.new(*arr, :fire_class, :smoke_color, display_class=true)
  CLASSES_OF_FIRE_QUESTIONS << ClassOfFireQuestion.new(*arr, :extinguishing_options, :smoke_color, display_class=true)
  CLASSES_OF_FIRE_QUESTIONS << ClassOfFireQuestion.new(*arr, :fuel, :smoke_color, display_class=true)
  CLASSES_OF_FIRE_QUESTIONS << ClassOfFireQuestion.new(*arr, :fire_class, :fuel, display_class=true)
  CLASSES_OF_FIRE_QUESTIONS << ClassOfFireQuestion.new(*arr, :extinguishing_options, :fuel, display_class=true)
  CLASSES_OF_FIRE_QUESTIONS << ClassOfFireQuestion.new(*arr, :smoke_color, :fuel, display_class=true)
end