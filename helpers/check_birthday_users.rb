

module CheckUsers

  def check_users_mareta(users)
    users.each do |user|
      birthday_user = Time.parse(user.birthday.to_s)
      birthday_user = Time.mktime(0, user.birthday.month, user.birthday.day)
      date_today = Time.parse(Date.today.to_s)
      date_today = Time.mktime(0, Date.today.month, Date.today.day)
      user.winner = true if birthday_user = date_today 
    end
  end

end