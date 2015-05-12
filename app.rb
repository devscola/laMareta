require 'sinatra'
require 'data_mapper'
require 'roo'
require 'pony'

# HELPERS
require './helpers/code'
require './helpers/check_birthday_users'
require './helpers/parse_excel'

# MODELS
require './models/vip_client.rb'
require './models/invitations.rb'

include Code
include CheckUsers




get '/' do
  erb :upload
end

post '/upload' do

  vip_clients = VipClients.all

  filename = 'uploads/' + params['birthdayFile'][:filename]

  File.open(filename, "w") do |f|
    f.write(params['birthdayFile'][:tempfile].read)
  end


  if filename =~ /xlsx$/
    excel = Roo::Excelx.new(filename)
  else
    excel = Roo::Excel.new(filename)
  end

  ExcelParser.parse(filename)
  
    @user = User.create(:name => name,:birthday => birthday, :email => email)
  redirect '/'
end

