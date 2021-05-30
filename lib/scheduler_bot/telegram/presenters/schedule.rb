class SchedulerBot::Telegram::Presenters::Schedule < SchedulerBot::Telegram::Presenters::Base
  def present
    join_data([present_header, present_weekdays])
  end

  private

  def present_header
    t('bot.schedule.header', group: data[:name])
  end

  def present_weekdays
    data.fetch(:weekdays, []).each_with_object([]) do |weekday, memo|
      next unless weekday[:pairs].present?

      memo << SchedulerBot::Telegram::Presenters::Weekday.new(weekday).present
    end
  end
end
