class Roll
  attr_reader :rolls

  def initialize
    @rolls = []
  end

  def <<(roll)
    rolls << roll
  end

  def concat(rolls_to_add)
    rolls.concat rolls_to_add.rolls
  end

  def total
    rolls.sum
  end

  def value
    case total
    when 1 then -10
    when 2 then -8
    when 3..4 then -6
    when 5..6 then -4
    when 7..8 then -2
    when 9..10 then -1
    when 11..12 then 0
    when 13..14 then 1
    when 15 then 2
    when 16 then 3
    when 17 then 4
    when 18 then 5
    when 19 then 6
    when 20 then 7
    else ((total - 1) / 5) + 4
    end
  end

  def to_s
    "#{rolls.join(' + ')} = #{total}, value = *#{value}*"
  end

  def to_bs  # to bonus string
    "#{rolls.join(' + ')} = #{total}"
  end
end
