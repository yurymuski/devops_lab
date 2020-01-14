#!/usr/bin/env ruby
require 'net/http'
require 'logger'

# This is main class
class Command
  ALL_COMMANDS = []
  LOG = Logger.new('errors.log')

  def self.command_by_name(list)
    p ALL_COMMANDS.detect { |e| e == list }
  end

  def cmd
    loop do
      begin
        print '> '
        name = gets.chomp.downcase
        temp = name.split(' ')
        @stdlog = File.open("#{File.basename $PROGRAM_NAME}.log", 'a') { |file| file.puts "#{Time.now}: #{temp}: " }
        if temp[0] == 'help'
          HelpCommand.new.run
        elsif temp[0] == 'uptime'
          UptimeCommand.new.run
        elsif temp[0] == 'date'
          DateCommand.new.run
        elsif temp[0] == 'echo'
          EchoCommand.new.run(temp[1])
        elsif temp[0] == 'ping'
          PingCommand.new.run(temp[1])
        elsif temp[0] == 'exit'
          puts 'Good Bye!'
          break
        else
          puts 'Unknown command' # else puts system name
        end
      rescue SystemExit, Interrupt
        puts 'Good Bye!'
        break
      rescue => e
        p e.message
        LOG.error "Type:#{e}"
      end
    end
  end

  def say(*a)
    puts "#{Time.now} #{File.basename $PROGRAM_NAME} args: #{a}"
  end
end

# This is uptime command class
class UptimeCommand < Command
  Command::ALL_COMMANDS.push(UptimeCommand)

  def self.name
    'command uptime'
  end

  def self.description
    'which print uptime'
  end

  def run
    uptime = File.read('/proc/uptime1').split[0].to_i
    hours = uptime / 3600
    mins = uptime % 3600 / 60
    secs = uptime % 60
    print "Uptime is #{hours}h #{mins}min #{secs}sec \n"
  end
end

# This is date command class
class DateCommand < Command
  Command::ALL_COMMANDS.push(DateCommand)

  def self.name
    'command date'
  end

  def self.description
    'which print currnet date'
  end

  def run
    puts "Current date is #{Time.now}"
  end
end

# This is echo command class
class EchoCommand < Command
  Command::ALL_COMMANDS.push(EchoCommand)

  def self.name
    'command echo'
  end

  def self.description
    'which print echo'
  end

  def run(*a)
    p a[0]
  end
end

# This is ping command class
class PingCommand < Command
  Command::ALL_COMMANDS.push(PingCommand)

  def self.name
    'command ping'
  end

  def self.description
    'which print ping'
  end

  def run(*host)
    if host[0]
      url = URI("http://#{host[0]}")
      status_response = Net::HTTP.get_response(url)
      p status_response.class
      p status_response.is_a? Net::HTTPSuccess
    else
      puts 'host is required'
    end
  end
end

# This is help command class
class HelpCommand < Command
  Command::ALL_COMMANDS.push(HelpCommand)

  def self.name
    'command help'
  end

  def self.description
    'which print this text'
  end

  def run
    Command::ALL_COMMANDS.each do |cmd|
      say "#{cmd.name} #{cmd.description}"
    end
  end
end

Command.new.cmd
