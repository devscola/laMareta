require 'sinatra'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'roo'
require 'pony'

require './helpers/code'
require './helpers/check_birthday_users'

include Code
include CheckUsers

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/users_mareta.db")

class User
	include DataMapper::Resource
	property :id, Serial
	property :name, Text#, :required => true
  property :birthday, Date#, :required => true
  property :email, Text
  has n, :invitations
end

class Invitation
  include DataMapper::Resource
  property :id, Serial
  property :code, Text
  property :created_at, DateTime
  property :updated_at, DateTime
  belongs_to :user
end

DataMapper.finalize.auto_upgrade!


get '/' do
  if File::exists?( "users_mareta.db" ) 
    @users = User.all
    CheckUsers.check_users_mareta(@users)
  end
  erb :upload
end

post '/upload' do
  users = User.all
  users.destroy
  
  filename = 'uploads/' + params['birthdayFile'][:filename]

  File.open(filename, "w") do |f|
    f.write(params['birthdayFile'][:tempfile].read)
  end


  if filename =~ /xlsx$/
    excel = Roo::Excelx.new(filename)
  else
    excel = Roo::Excel.new(filename)
  end

  3.upto(excel.last_row) do |line|
    name = excel.cell(line,'A')
    birthday = excel.cell(line,'B')
    email = excel.cell(line, 'C')

    @user = User.create(:name => name,:birthday => birthday, :email => email)
  end
    # user_birthday = user.birthday.to_s.split('-')
    # user_birthday.shift
    # user_birthday = user_birthday.join
    # date = Date.today.to_s.split('-')
    # date.shift
    # date = date.join
    # if user_birthday = date
    #   Pony.mail({:to => user.email,
    #         :from => "daviddsrperiodismo@gmail",
    #         :subject => 'Happy Birthday¡¡',
    #         :body => "Happy Birthday #{user.name}, you have a free meal with this code #{Code.generate}",
    #         :via => :smtp,
    #         :via_options => {
    #           :address              => 'smtp.gmail.com',
    #           :port                 => '587',
    #           :enable_starttls_auto => true,
    #           :user_name            => 'daviddsrperiodismo@gmail.com',
    #           :password             => '20041990',
    #           :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
    #           :domain               => "localhost" # the HELO domain provided by the client to the server
    #         }})
    # end
  
  redirect '/'
end
