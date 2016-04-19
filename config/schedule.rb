# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
set :output, 'log/cron.log'

every '*/7 * * * *' do
  runner "Tasks::Bitflyer::TradeTask.new.execute"
end
every '*/9 * * * *' do
  runner "Tasks::Zaif::TradeTask.new.execute"
end
every '*/11 * * * *' do
  runner "Tasks::Coincheck::TradeTask.new.execute"
end
# Learn more: http://github.com/javan/whenever
