require 'telegram/bot'

class SchedulerBot::Telegram::CommandsHandler < Telegram::Bot::UpdatesController
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

  def send_message(message)
    respond_with :message, text: message
  end

  def send_localized_message(message, options = {})
    send_message t("bot.#{message}", **options)
  end

  def username
    from['first_name'] || from['user_name']
  end
end
