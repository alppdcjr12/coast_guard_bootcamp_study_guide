class Order
  
  GENERAL_ORDERS = [
    "To take charge of this post and all government property in view.",
    "To walk my post in a military manner, keeping always on the alert, and observing everything that takes place within sight or hearing.",
    "To report all violations of orders I am instructed to enforce.",
    "To repeat all calls from posts more distant from the guardhouse than my own.",
    "To quit my post only when properly relieved.",
    "To receive, obey and pass on to the sentry who relieves me all orders from the Commanding Officer, Field Officer of the Day, Officer of the Day, and Officers and Petty Officers of the Watch.",
    "To talk to no one except in the line of duty.",
    "To raise the alarm in case of fire or disorder.",
    "To call the Petty Officer of the Watch in any case not covered by instructions.",
    "To salute all officers and all colors and standards not cased.",
    "To be especially watchful at night, and during the time for challenging, to challenge all persons on or near my post, and to allow no one to pass without proper authority."
  ]
  
    attr_reader :number, :content, :ordinal

  def initialize(number, content)
    @number = number + 1
    @ordinal = set_ordinal
    @content = content

  end

  def set_ordinal
    suffixes = {1 => "st", 2 => "nd", 3 => "rd"}
    suffix = @number > 3 ? "th" : suffixes[@number]
    "#{@number}#{suffix}"
  end

  def ask
    puts "What is the #{ordinal} general order?"
    STDIN.gets
    puts "The #{ordinal} general order is '#{@content}'"
    STDIN.gets
    system 'cls'
  end

end

GENERAL_ORDERS_QUESTIONS = Order::GENERAL_ORDERS.map.with_index do |order, i|
  Order.new(i, order)
end