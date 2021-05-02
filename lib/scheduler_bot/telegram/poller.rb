require 'i18n'
require 'logger'

require 'telegram/bot'

class SchedulerBot::Telegram::Poller
  include Singleton

  def start!
    load_locales
    build_poller.start
  end

  private

  def load_locales
    I18n.load_path = Dir['locales/*.yml']
    I18n.backend.load_translations
  end

  def build_poller
    Telegram::Bot::UpdatesPoller.new(build_client, SchedulerBot::Telegram::CommandsHandler, logger: SchedulerBot.logger)
  end

  def build_client
    Telegram::Bot::Client.new(SchedulerBot.configuration.telegram.token)
  end
end
