class SchedulerBot::Telegram::Presenters::Weekday < SchedulerBot::Telegram::Presenters::Base
  WEEKDAYS = [
    :mon,
    :tue,
    :wed,
    :thu,
    :fri,
    :sat,
    :sun
  ].freeze

  def present
    join_data([present_header, present_pairs], "\n")
  end

  private

  def present_header
    t('bot.schedule.weekday.header', weekday: present_weekday_name)
  end

  def present_weekday_name
    t("bot.common.weekdays.#{WEEKDAYS[data.fetch(:number, 0)]}")
  end

  def present_pairs
    data.fetch(:pairs, []).map do |pair|
      SchedulerBot::Telegram::Presenters::Pair.new(pair).present
    end
  end
end
