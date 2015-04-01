require 'sinatra'
require './helpers/excel2csv'

include ExcelToCsv

get '/' do
	erb :upload
end

post '/upload' do
	File.open('uploads/' + params['birthdayFile'][:filename], "w") do |f|
    f.write(params['birthdayFile'][:tempfile].read)
  end
  ExcelToCsv.convert_excel_to_csv('uploads/' + params['birthdayFile'][:filename])
end
