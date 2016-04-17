# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
set :output, 'log/cron.log'

every 1.minute do
  runner "Tasks::Bitflyer::TradeTask.new.execute"
  runner "Tasks::Zaif::TradeTask.new.execute"
  runner "Tasks::Coincheck::TradeTask.new.execute"
end

# Learn more: http://github.com/javan/whenever
