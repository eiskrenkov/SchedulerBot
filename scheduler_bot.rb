require 'logger'

require './lib/core_ext/object'
require './lib/core_ext/hash'

module SchedulerBot
  autoload :Configuration, './lib/scheduler_bot/configuration'

  module Telegram
    autoload :Poller, './lib/scheduler_bot/telegram/poller'
    autoload :CommandsHandler, './lib/scheduler_bot/telegram/commands_handler'

    module Commands
      autoload :Groups, './lib/scheduler_bot/telegram/commands/groups'
      autoload :Schedule, './lib/scheduler_bot/telegram/commands/schedule'
    end

    module Presenters
      autoload :Base, './lib/scheduler_bot/telegram/presenters/base'
      autoload :Schedule, './lib/scheduler_bot/telegram/presenters/schedule'
      autoload :Weekday, './lib/scheduler_bot/telegram/presenters/weekday'
      autoload :Pair, './lib/scheduler_bot/telegram/presenters/pair'
    end
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
