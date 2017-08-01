require 'slack-ruby-bot'
require_relative 'player'
require_relative 'roller'

SlackRubyBot.configure do |config|
  config.aliases = ['t']
end

class TorgBot < SlackRubyBot::Bot
  command 'ping' do |client, data, match|
    puts data.class
    puts data.to_s
    client.say text: "a pong for <@#{data.user}>", channel: data.channel
  end

  command 'help' do |client, data, match|
    msg = "torgbot commands\n" +
          "  *nick* - show your nickname\n" +
          "  *nick* nickname - set your nickname\n" +
          "  *roll* or *skilled* - a roll that explodes on 10 and 20\n" +
          "  *unskilled* - a roll that only explodes on 10\n" +
          "  *hero* or *drama* or *pp* - an exploding roll with a minimum value of " +
             "10, added to your previous roll\n" +
          "  *bonus* - a d6 roll that explodes on 6s\n"

    client.say text: msg, channel: data.channel
  end

  command 'nick' do |client, data, match|
    player = players[data.user]
    nick = match[:expression]

    if nick.nil?
      msg = "Nickname is #{player.name}"
    else
      player.nick = nick
      msg = "Changing nickname to #{nick}"
    end

    client.say text: msg, channel: data.channel
  end

  command 'roll', 'skilled' do |client, data, match|
    player = players[data.user]
    r = Roller.new

    roll = r.skilled
    player.last_roll = roll

    msg = "#{player.name} rolled:\n" +
          "#{roll.to_s}"
    client.say text: msg, channel: data.channel
  end

  command 'unskilled' do |client, data, match|
    player = players[data.user]
    r = Roller.new

    roll = r.unskilled
    player.last_roll = roll

    msg = "#{player.name} rolled:\n" +
          "#{roll.to_s}"
    client.say text: msg, channel: data.channel
  end

  command 'hero', 'drama', 'possibility', 'pp' do |client, data, match|
    player = players[data.user]
    last_roll = player.last_roll

    if last_roll.nil?
      client.say text: "#{player.name} hasn't rolled yet", channel: data.channel
      return
    end

    r = Roller.new
    roll = r.possibility(last_roll)
    player.last_roll = roll

    msg = "#{player.name} rolled:\n" +
          "#{roll.to_s}"
    client.say text: msg, channel: data.channel
  end

  command 'bonus' do |client, data, match|
    player = players[data.user]
    r = Roller.new

    roll = r.bonus

    msg = "#{player.name} rolled:\n" +
          "#{roll.to_bs}"
    client.say text: msg, channel: data.channel
  end

  def self.players
    @players ||= Hash.new { |h, k| h[k] = Player.new(k) }
  end
end

TorgBot.run
