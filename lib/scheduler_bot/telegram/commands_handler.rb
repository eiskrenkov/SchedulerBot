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

  def set_group!(group_name = nil, *)
    return send_localized_message('set_group.no_group_passed') unless group_name

    message = request_group_update(group_name) ? :success : :failure
    send_localized_message("set_group.#{message}")
  end

  private

  def request_group_update(group_name)
    SchedulerBot::Api::Client::Scheduler.instance.set_group(telegram_id: telegram_id, group_name: group_name)
  end

  def send_message(message)
    respond_with :message, text: message
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
