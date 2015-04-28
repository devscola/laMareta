require 'sinatra'
require 'data_mapper'
require 'roo'
require 'pony'

# HELPERS
require './helpers/code'
require './helpers/check_birthday_users'

# MODELS
require './models/users.rb'
require './models/invitations.rb'

include Code
include CheckUsers

configure :test do
  DataMapper.setup(:default, 'postgres://postgres@localhost/usersmareta')
end

configure :development do
  DataMapper.setup(:default, 'postgres://postgres:12345@localhost/usersmareta')
end

configure :production do
  DataMapper.setup(:default, ENV['POSTGRES_URL'])
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
  end
  erb :sendinvitations
end
