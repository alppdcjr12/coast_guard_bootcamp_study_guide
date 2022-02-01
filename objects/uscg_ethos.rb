class USCGEthosQuestion
  
  USCG_ETHOS = """
I am a Coast Guardsman.
I serve the people of the United States.
I will protect them.
I will defend them.
I will save them.
I am their shield.
For them I am Semper Paratus.
I live the Coast Guard Core Values.
I am proud to be a Coast Guardsman.
We are the United States Coast Guard.
  """

  attr_reader :ethos

  def initialize
    @ethos = USCG_ETHOS
  end

  def ask
    puts "What is the ethos of the United States Coast Guard?"
    STDIN.gets
    puts @ethos
    STDIN.gets
    system 'cls'
  end

end

USCG_ETHOS_QUESTION = [USCGEthosQuestion.new]