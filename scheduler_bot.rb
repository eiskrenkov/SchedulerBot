require 'logger'

module SchedulerBot
  autoload :Configuration, './lib/scheduler_bot/configuration'

  module Telegram
    autoload :Poller, './lib/scheduler_bot/telegram/poller'
    autoload :CommandsHandler, './lib/scheduler_bot/telegram/commands_handler'
  end

  class << self
    def configuration
      @configuration ||= Configuration.load
    end

    def logger
      @logger ||= Logger.new('log/scheduler_bot.log', level: configuration.log_level)
    end
  end
end
