module VersionsHelper
  def admin_action(version)
    action = "#{(t 'general.action.created')} um(a)" if version.event == 'create'
    action = "#{(t 'general.action.updated')} um(a)" if version.event == 'update'
    action = "#{(t 'general.action.destroyed')} um(a)" if version.event == 'destroy'
    author = User.find(version.whodunnit)
    item_type = version.item_type
    with = ""
    if item_type == 'Friendship'
      user = User.find(version.item_id)
      with = "#{user||"<i>[usuário apagado]</i>"}"
      action = 'enviou solicitação de amizade para' if version.event == 'create'
      action = 'aceitou convite de' if version.event == 'update'
      action = 'desfez a amizade com' if version.event == 'destroy'
      item_type = ""
    elsif item_type == 'BlockedUser'
      user = User.find(version.item_id)
      with = "#{user||"<i>[usuário apagado]</i>"}"
      action = 'bloqueou' if version.event == 'create'
      action = 'desbloqueou' if version.event == 'destroy'
      item_type = ""
    elsif item_type == 'Follower'
      user = User.find(version.item_id)
      with = "#{user||"<i>[usuário apagado]</i>"}"
      action = 'seguiu' if version.event == 'create'
      action = 'deixou de seguir' if version.event == 'destroy'
      item_type = ""
    end
    "<a href='#{user_path(author)}'>#{author.first_name}</a> #{action} #{item_type} #{with}".html_safe
  end
end
