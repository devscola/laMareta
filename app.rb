require 'sinatra'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'roo'
require 'pony'

require './helpers/code'
require './helpers/check_birthday_users'
require './helpers/send_email_invitation'

include Code
include CheckUsers
include SendInvitation

#DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/users_mareta.db")

configure :development do
  DataMapper.setup(:default, 'postgres://david:123456@localhost/usersmareta')
end

class User
	include DataMapper::Resource
	property :id, Serial
	property :name, Text#, :required => true
  property :birthday, Date#, :required => true
  property :email, Text
  property :winner, Boolean, :default => false
  has n, :invitations
end

class Invitation
  include DataMapper::Resource
  property :id, Serial
  property :created_at, DateTime
  property :updated_at, DateTime
  belongs_to :user
end

DataMapper.finalize.auto_upgrade!


get '/' do
  erb :upload
end

post '/upload' do

  users = User.all
  users.destroy if users.any?

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

    @user = User.create(:name => name,:birthday => birthday, :email => email, :winner => false)
  end
  redirect '/'
end

get '/sendinvitations' do
  @users = User.all
  if @users.any?
    CheckUsers.check_users_mareta(@users)
    SendInvitation.send_email_invitation(@users)
  end
  erb :sendinvitations
end

