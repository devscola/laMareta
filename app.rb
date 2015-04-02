require 'sinatra'
require 'data_mapper'
require 'dm-sqlite-adapter'
require './helpers/excel2csv'
require './helpers/csv_to_db'

include ExcelToCsv
include CsvToDatabase

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/users_mareta.db")

class User
	include DataMapper::Resource
	property :id, Serial
	property :name, Text#, :required => true
  property :birthday, Date#, :required => true
end

DataMapper.finalize.auto_upgrade!

get '/' do
  erb :upload
end

post '/upload' do
  File.open('uploads/' + params['birthdayFile'][:filename], "w") do |f|
    f.write(params['birthdayFile'][:tempfile].read)
  end
  ExcelToCsv.convert_excel_to_csv('uploads/' + params['birthdayFile'][:filename], "uploads/filename.csv")
  CsvToDatabase.csv_to_database('uploads/filename.csv').each do |line|
    user = User.create
    user.name = line[:nombre]
    user.birthday = line[:fecha]
    user.save
    puts user
  end
end
