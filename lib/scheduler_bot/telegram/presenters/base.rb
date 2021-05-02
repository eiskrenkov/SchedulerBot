require 'i18n'

class SchedulerBot::Telegram::Presenters::Base
  attr_reader :data

  def initialize(data)
    @data = data.deep_symbolize_keys
  end

  def present
    raise NotImplementedError
  end

  private

  def join_data(parts, separator = "\n\n")
    parts.join(separator)
  end

  def reject_blank(parts, separator)
    join_data(parts.reject(&:blank?), separator)
  end

  def t(path, options = {})
    I18n.t(path, **options)
  end
end
