require 'logger'

require './lib/core_ext/object'

module SchedulerBot
  autoload :Configuration, './lib/scheduler_bot/configuration'

  module Telegram
    autoload :Poller, './lib/scheduler_bot/telegram/poller'
    autoload :CommandsHandler, './lib/scheduler_bot/telegram/commands_handler'
  end

  module Api
    autoload :Signature, './lib/scheduler_bot/api/signature'

    module Client
      autoload :Base, './lib/scheduler_bot/api/client/base'
      autoload :Scheduler, './lib/scheduler_bot/api/client/scheduler'
    end
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
