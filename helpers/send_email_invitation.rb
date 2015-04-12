
require 'pony'
require './helpers/code'

include Code

module SendInvitation

  def send_email_invitation(users)
    users.each do |user|
      if user.winner = true
      Pony.mail({:to => user.email,
                 :from => "daviddsrperiodismo@gmail",
                 :subject => 'Happy Birthday¡¡',
                 :body => "Happy Birthday #{user.name}, you have a free meal with this code #{Code.generate}",
                 :via => :smtp,
                 :via_options => {
                   :address              => 'smtp.gmail.com',
                   :port                 => '587',
                   :enable_starttls_auto => true,
                   :user_name            => 'daviddsrperiodismo@gmail.com',
                   :password             => '20041990',
                   :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
                   :domain               => "localhost" # the HELO domain provided by the client to the server
                 }})
      user.winner = false
      end 
    end   
  end
end