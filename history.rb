class History
  FACTS = {
    "What organization does the Coast Guard originally trace its roots to?": "The United States Revenue Cutter Service",
    "Who established the Revenue Cutter Services?": "Alexander Hamilton",
    "Who was the 'father of the Coast Guard'?": "Alexander Hamilton",
    "What department was the Revenue Cutter Services established under?": "The Department of the Treasury",
    "When was the Revenue Cutter Services established?": "August 4th, 1790",
    "What did the initial laws establishing the Revenue Cutter Service authorize?": "The building of ten cutters tasked with enforcement of tariff laws and prevention of smuggling",
    "What were the original ten cutters in the Revenue Cutter Service named?": "Massachusetts, Scammel, Active, Eagle, Diligence, Argus, Vigilant, Virginia, South Carolina, and General Greene",
    "When was the modern Coast Guard created?": "January 28th, 1915",
    "What two organizations merged to form the modern Coast Guard?": "The U.S. Revenue Cutter Service and the U.S. Lifesaving Service",
    "Who signed into law the Act to Create the Coast Guard?": "President Woodrow Wilson",
    "What law created the Coast Guard?": "The Act to Create the Coast Guard of 1915",
    "What organization was added to the Coast Guard in 1939?": "The U.S. Lighthouse Service",
    "What department was transferred to the Coast Guard in 1942?": "The Bureau of Marine Inspection and Navigation",
    "What happened in 1967?": "The Coast Guard was transferred from the Department of the Treasury to the Department of Transporation.",
    "What happened in 2003?": "The Coast Guard was transferred from the Department of Transportation to the new Department of Homeland Security in response to the September 11, 2001 terrorist attacks.",
    "What law defines the five uniformed services that make up the Armed Forces?": "10 U.S.C. 101(a) (4)",
    "What is defined by 10 U.S.C. 101(a) (4)?": "The five uniformed services that make up the Armed Forces",
    "What are the five uniformed services that make up the Armed Forces?": "The Army, Navy, Air Force, Marine Corps, and the Coast Guard",
    "What law further defines the Coast Guard as a branch of the Armed Forces?": "10 U.S.C. 1",
    "What does 10 U.S.C. 1 state in regards to the Coast Guard?": "The Coast Guard as established 28 January 1915 shall be a military service and a branch of the Armed Forces of the United States at all times. The Coast Guard shall be a service in the Deparment of Homeland Security except when operating as a service in the Navy."
  }

  attr_reader :question, :answer

  def initialize(question, answer)
    @question = question
    @answer = answer
  end

  def ask
    puts @question
    gets
    puts @answer
    gets
    system 'cls'
  end

end

HISTORY_QUESTIONS = []

History::FACTS.each do |k, v|
  HISTORY_QUESTIONS << History.new(k, v)
end