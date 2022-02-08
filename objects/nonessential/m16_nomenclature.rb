require "csv"

class M16NomenclatureQuestion
  M16_PARTS = CSV.read("resources/nonessential/m16_nomenclature.csv")

  attr_reader :m_16_part

  def initialize(type, m_16_part=nil)
    @type = type
    @m_16_part = m_16_part
    if type == "one_at_a_time"
      @question = "Next?"
      @answer = @m_16_part
    elsif type == "complete_nomenclature"
      @question = "What is your piece nomenclature?"
      @answer = M16_PARTS
        .map
        .with_index { |arr, i| "#{i}: #{arr[0]}"  }
        .join("\n")
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
 
M16_NOMENCLATURE_QUESTION = [M16NomenclatureQuestion.new(type="complete_nomenclature")]

LIST_ALL_M16_NOMENCLATURE_QUESTIONS = M16NomenclatureQuestion::M16_PARTS.map do |arr|
  M16NomenclatureQuestion.new(type="one_at_a_time", m_16_part=arr[0])
end.reverse