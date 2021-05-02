module SchedulerBot::Telegram::Commands::Schedule
  def schedule!(*)
    schedule_data = request_schedule
    return send_localized_message('schedule.failure') unless schedule_data.present?

    send_message(present_schedule(schedule_data))
  end

  private

  def present_schedule(schedule_data)
    SchedulerBot::Telegram::Presenters::Schedule.new(schedule_data).present
  end

  def request_schedule
    scheduler_api_client.schedule(telegram_id: telegram_id)
  end

  def scheduler_api_client
    raise NotImplementedError
  end
end
