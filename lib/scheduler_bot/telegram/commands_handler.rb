require 'telegram/bot'

class SchedulerBot::Telegram::CommandsHandler < Telegram::Bot::UpdatesController
  include SchedulerBot::Telegram::Commands::Fallback
  include SchedulerBot::Telegram::Commands::Groups
  include SchedulerBot::Telegram::Commands::Schedule

  def start!(*)
    send_localized_message :start, locale: { username: username }
  end

  def help!(*)
    send_localized_message :help, parse_mode: nil
  end

  def ping!(*)
    send_message :pong
  end

  private

  def scheduler_api_client
    @scheduler_api_client ||= SchedulerBot::API::Client::Scheduler.instance
  end

  def send_message(message, parse_mode: :markdown)
    respond_with(:message, text: message, parse_mode: parse_mode)
  end

  def send_localized_message(message, options = {})
    send_message(t("bot.#{message}", **options.delete(:locale).to_h), **options)
  end

  def username
    from['first_name'] || from['user_name']
  end

  def telegram_id
    from['id']
  end
end
