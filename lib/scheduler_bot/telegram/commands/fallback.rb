module SchedulerBot::Telegram::Commands::Fallback
  FALLBACK_HANDLER = 'fallback!'.freeze

  def action_for_command(cmd)
    command = super
    return command if respond_to?(command)

    FALLBACK_HANDLER
  end

  def fallback!(*)
    send_localized_message :unknown
  end
end
