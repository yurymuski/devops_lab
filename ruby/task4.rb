#!/usr/bin/env ruby
require 'net/http'
class Command
  ALL_COMMANDS = []
  def self.command_by_name(list)
    p ALL_COMMANDS.detect { |e| e == list}
  end
  def cmd
    loop do
      print '> '
      name= gets.chomp.downcase
      temp = name.split(' ')
      if temp[0] == "help"
        HelpCommand.new.run
      elsif temp[0] == "uptime"
        UptimeCommand.new.run
      elsif temp[0] == "date"
        DateCommand.new.run
      elsif temp[0] == "echo"
        EchoCommand.new.run(temp[1])
      elsif temp[0] == "ping"
        PingCommand.new.run(temp[1])
      elsif temp[0] == "exit"
        break
#      else puts system name
      else puts "Unknown command"
      end
    end
  end
  def say(*a)
    puts "#{Time.now} #{File.basename$0} args: #{a}"
  end
end

class UptimeCommand < Command
  Command::ALL_COMMANDS.push(UptimeCommand)
  def self.name
    "command uptime"
  end
  def self.description
    "which print uptime"
  end
  def run
    uptime=File.read('/proc/uptime').split[0].to_i
    hours=uptime/3600
    mins=uptime%3600/60
    secs=uptime%60
    print "Uptime is #{hours}h #{mins}min #{secs}sec \n"
  end
end

class DateCommand < Command
  Command::ALL_COMMANDS.push(DateCommand)
  def self.name
    "command date"
  end
  def self.description
    "which print currnet date"
  end
  def run
    puts "Current date is #{Time.now}"
  end
end

class EchoCommand < Command
  Command::ALL_COMMANDS.push(EchoCommand)
  def self.name
    "command echo"
  end
  def self.description
    "which print echo"
  end
  def run(*a)
    p a[0]
  end
end

class PingCommand < Command
  Command::ALL_COMMANDS.push(PingCommand)
  def self.name
    "command ping"
  end
  def self.description
    "which print ping"
  end
  def run(*host)
    if host[0]
      url = URI("http://#{host[0]}")
      status_response = Net::HTTP.get_response(url)
      p status_response.class
      p status_response.kind_of? Net::HTTPSuccess
    else
      puts 'host is required'
    end

  end
end

class HelpCommand < Command
  Command::ALL_COMMANDS.push(HelpCommand)
  def self.name
    "command help"
  end
  def self.description
    "which print this text"
  end
  def run
    Command::ALL_COMMANDS.each do |cmd|
      say "#{cmd.name} #{cmd.description}"
    end
  end
end

Command.new.cmd


