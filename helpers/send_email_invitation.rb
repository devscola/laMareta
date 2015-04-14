
require 'pony'
require './helpers/code'

include Code

module InvitationSender

  def send_invitation_to(user)
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
      invitation = Invitation.create
      invitation.created_at = Time.now
      invitation.updated_at = Time.now
      invitation.user = user
      invitation.save
      invitation  
  end
end