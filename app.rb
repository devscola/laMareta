require 'sinatra'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'roo'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/users_mareta.db")

class User
  include DataMapper::Resource
  property :id, Serial
  property :name, Text
  property :birthday, Date
end

DataMapper.finalize.auto_upgrade!

get '/' do
  erb :upload
end

post '/upload' do
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

    @user = User.create(:name => name,:birthday => birthday)
  end
end
