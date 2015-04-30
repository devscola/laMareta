
require 'pony'
require './helpers/code'

include Code

module InvitationSender

  def send_invitation_to(user)
      Pony.mail({:to => user.email,
                 :from => ENV['MAIL_USERNAME'],
                 :subject => 'Happy Birthday¡¡',
                 :body => "Happy Birthday #{user.name}, you have a free meal with this code #{Code.generate}",
                 :via => :smtp,
                 :via_options => {
                   :address              => ENV['MAIL_DOMAIN'],
                   :port                 => '587',
                   :enable_starttls_auto => true,
                   :user_name            => ENV['MAIL_USERNAME'],
                   :password             => ENV['MAIL_PASSWORD'],
                   :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
                   :domain               => ENV['HELO_DOMAIN'] # the HELO domain provided by the client to the server
                 }})
      invitation = Invitation.create
      invitation.created_at = Time.now
      invitation.updated_at = Time.now
      invitation.user = user
      invitation.save
      invitation
  end
end
