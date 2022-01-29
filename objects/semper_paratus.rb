class SemperParatusQuestion
  
  VERSES = {
    "Verse 1" => """
From Aztec shore to Arctic Zone, to Europe and Far East,
The Flag is carried by our ships in times of war and peace;
And never have we struck it yet, in spite of foemen's might,
Who cheered our crews and cheered again for showing how to fight.
    """,
    "Verse 2" => """
'Surveyor' and 'Narcissus,' the 'Eagle' and 'Dispatch,'
The 'Hudson' and the 'Tampa,' these names are hard to match;
From Barrow's shores to Paraguay, Great Lakes or Ocean's wave,
The Coast Guard fights through storms and winds to punish or to save.
    """,
    "Verse 3" => """
Aye! We've been 'Always Ready' to do, to fight, or die!
Write glory to the shield we wear in letters to the sky.
To sink the foe or save the maimed our mission and our pride.
We'll carry on 'til Kingdom Come, ideals for which we've died.
    """,
    "Chorus" => """
We're always ready for the call, We place our trust in Thee.
Through surf and storm and howling gale, High shall our purpose be.
'Semper Paratus' is our guide, Our fame, our glory too,
To fight to save or fight and die! Aye! Coast Guard, we are for you.
    """,

  }

  attr_reader :verse, :content

  def initialize(verse, content)
    @verse = verse
    @content = content

  end

  def ask
    puts "What is the #{@verse} of 'Semper Paratus'?"
    STDIN.gets
    puts @content
    STDIN.gets
    system 'cls'
  end

end

SEMPER_PARATUS_QUESTIONS = SemperParatusQuestion::VERSES.map do |verse, content|
  SemperParatusQuestion.new(verse, content)
end