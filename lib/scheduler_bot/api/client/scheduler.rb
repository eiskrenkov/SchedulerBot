class SchedulerBot::Api::Client::Scheduler < SchedulerBot::Api::Client::Base
  def ping
    get('ping')
  end

  def set_group(telegram_id:, group_name:)
    post('api/telegram/set_group', telegram_id: telegram_id, group_name: group_name).successful?
  end

  private

  def api_host
    @api_host ||= scheduler_configuration.api.host
  end

  def api_secret
    @api_secret ||= scheduler_configuration.api.secret
  end

  def common_params
    { application_id: scheduler_configuration.application_id }
  end

  def scheduler_configuration
    @scheduler_configuration ||= SchedulerBot.configuration.scheduler
  end
end