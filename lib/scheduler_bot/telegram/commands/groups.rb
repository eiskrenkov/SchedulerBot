module SchedulerBot::Telegram::Commands::Groups
  def list_groups!(*)
    send_localized_message 'groups.list', locale: { groups: request_groups_list }
  end

  def set_group!(group_name = nil, *)
    return send_localized_message('groups.set.no_group_passed') unless group_name

    message = request_group_update(group_name) ? :success : :failure
    send_localized_message("groups.set.#{message}")
  end

  private

  def request_group_update(group_name)
    scheduler_api_client.set_group(telegram_id: telegram_id, group_name: group_name)
  end

  def request_groups_list
    scheduler_api_client.list_groups(telegram_id: telegram_id).join(', ')
  end

  def scheduler_api_client
    raise NotImplementedError
  end
end
