#!/usr/bin/env ruby
=begin
1)
  yum install ruby ruby-devel ruby-irb
  yum install rubygems
  yum install sqlite-devel
  gem install pry sqlite3
  gem uninstall sqlite3 pry
  yum remove ruby ruby-devel ruby-irb rubygems sqlite-devel
2)
  yum install сurl
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  \curl -sSL https://get.rvm.io | bash -s stable
  source ~/.rvm/scripts/rvm # (или переоткрыть терминал)
  rvm requirements
3)
  rvm gemset create mnt
  rvm gemset use mnt --default
4)
  gem install pry sqlite3
=end

# ex1
baskets = {red:50, green:100, blue:30, yellow:60}
puts baskets.key baskets.values.max

#baskets[:green]=70
#color = 'yellow'
#p baskets[color.to_sym]

if baskets[:green] > baskets[:yellow] || baskets[:green] > baskets[:red]+baskets[:blue]
  then puts 'There are more balls in green basket then in yellow or more then in blue and red together'
  else puts 'There are less balls in green basket then in yellow or less then in blue and red together'
end

#ex2
usd_exch=20150
tax=1.3
usd_to_by=270
puts "To buy #{usd_to_by} USD you need #{usd_exch*tax*usd_to_by} BYR"

byr=5600000
icecream=10000
if byr%(usd_exch*tax) > icecream
  then puts "You can buy #{(byr/usd_exch/tax).to_i} USD and an icecream"
  else puts "You can buy #{(byr/usd_exch/tax).to_i} USD and no icecream"
end
