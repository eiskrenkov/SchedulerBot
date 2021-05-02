class SchedulerBot::Telegram::Presenters::Pair < SchedulerBot::Telegram::Presenters::Base
  def present
    reject_blank(["#{data[:start_time]} - #{data[:name]}", data[:teacher], present_pair_kind, data[:place]], ', ')
  end

  private

  def pair_options
    data.slice(:start_time, :name, :teacher, :place).merge(kind: present_pair_kind)
  end

  def present_pair_kind
    t("bot.schedule.weekday.pair.kind.#{data[:kind]}") if data[:kind].present?
  end
end
