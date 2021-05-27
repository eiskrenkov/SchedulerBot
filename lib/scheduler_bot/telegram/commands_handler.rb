require 'telegram/bot'

class SchedulerBot::Telegram::CommandsHandler < Telegram::Bot::UpdatesController
  include SchedulerBot::Telegram::Commands::Groups
  include SchedulerBot::Telegram::Commands::Schedule

  def start!(*)
    send_localized_message :start, username: username
  end

  def help!(*)
    send_localized_message :help
  end

  def ping!(*)
    send_message :pong
  end

  private

  def scheduler_api_client
    @scheduler_api_client ||= SchedulerBot::API::Client::Scheduler.instance
  end

  def send_message(message)
    respond_with :message, text: message, parse_mode: :markdown
  end

  def send_localized_message(message, options = {})
    send_message t("bot.#{message}", **options)
  end

  def username
    from['first_name'] || from['user_name']
  end

  def telegram_id
    from['id']
  end
end
