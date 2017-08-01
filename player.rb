class Player
  attr_accessor :id, :nick
  attr_reader :last_roll, :last_roll_time

  def initialize(id)
    self.id = id
  end

  def name
    if nick.nil?
      "<@#{id}>"
    else
      nick
    end
  end

  def last_roll=(roll)
    @last_roll = roll
    @last_roll_time = Time.now
  end

end
