require_relative "roll"

class Roller

  def skilled(roll = Roll.new)
    loop do
      r = d20
      roll << r
      break unless r == 10 || r== 20
    end

    roll
  end

  def unskilled(roll = Roll.new)
    loop do
      r = d20
      roll << r
      break unless r == 10 || r== 20
    end

    roll
  end

  def possibility(roll)
    r = skilled

    if r.total < 10
      roll << 10
    else
      roll.concat r
    end

    roll
  end

  def bonus(roll = Roll.new)
    loop do
      r = d6

      if r != 6
        roll << r
        break
      else
        roll << 5
      end
    end

    roll
  end

private

  def d20
    rand(20) + 1
  end

  def d6
    rand(6) + 1
  end
end
