
require './helpers/send_email_invitation'

include InvitationSender

module CheckUsers

  def check_users_mareta(users)
    users.each do |user|
      next unless user_needs_invitation?(user)
      InvitationSender.send_invitation_to(user)
    end
  end

  private

  def user_birthday_is_today?(user)
    birthday_user = Time.parse(user.birthday.to_s)
    birthday_user = Time.mktime(0, user.birthday.month, user.birthday.day)
    date_today = Time.parse(Date.today.to_s)
    date_today = Time.mktime(0, Date.today.month, Date.today.day)

    birthday_user == date_today
  end

  def user_has_not_been_invited_today?(user)
    return true unless user.respond_to?(:invitations)

    invitations_user = user.invitations.all(:created_at.gte => Date.today).count
    p invitations_user
    invitations_user == 0
  end

  def user_needs_invitation?(user)
    user_birthday_is_today?(user) && user_has_not_been_invited_today?(user)
  end

end