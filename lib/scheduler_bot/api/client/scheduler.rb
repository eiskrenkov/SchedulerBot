class SchedulerBot::API::Client::Scheduler < SchedulerBot::API::Client::Base
  def ping
    get('ping')
  end

  def list_groups(telegram_id:)
    handle_errrors([]) do
      get('api/telegram/groups/list', telegram_id: telegram_id)
    end
  end

  def set_group(telegram_id:, group_name:)
    post('api/telegram/groups/set', telegram_id: telegram_id, group_name: group_name).successful?
  end

  def schedule(telegram_id:)
    handle_errrors({}) do
      get('api/telegram/schedule', telegram_id: telegram_id)
    end
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
    @scheduler_configuration ||= Configuration.scheduler
  end
end
