require './scheduler_bot'

namespace :telegram do
  namespace :bot do
    task :start do
      SchedulerBot::Telegram::Poller.instance.start!
    end
  end
end
