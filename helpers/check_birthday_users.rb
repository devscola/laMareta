

module CheckUsers

  def check_users_mareta(users)
    users.each do |user|
      birthday_user = Time.parse(user.birthday.to_s)
      birthday_user = Time.mktime(0, user.birthday.month, user.birthday.day)
      date_today = Time.parse(Date.today.to_s)
      date_today = Time.mktime(0, Date.today.month, Date.today.day)
      p user.respond_to?(:invitations)
      if user.respond_to?(:invitations)
        p user.invitations
        invitations_user = user.invitations.all(:created_at.gte => Date.today).count
        p invitations_user
        if birthday_user == date_today && invitations_user == 0
          user.winner = true  
        end      
      else 
        if birthday_user == date_today
        user.winner = true
        end
      end
    end
  end

end