require 'sinatra'
require 'roo'
require 'csv'

get '/' do
	erb :upload
end

post '/upload' do
	File.open('uploads/' + params['birthdayFile'][:filename], "w") do |f|
    f.write(params['birthdayFile'][:tempfile].read)
  end
  excelFile = 'uploads/' + params['birthdayFile'][:filename]
  csv_converter(excelFile)

end

def csv_converter (excelFile)
  if excelFile =~ /xlsx$/
    excel = Roo::Excelx.new(excelFile)
  else
    excel = Roo::Excel.new(excelFile)
  end

  output = File.open('uploads/test.csv', "w")

2.upto(excel.last_row) do |line|
  output.write CSV.generate_line excel.row(line)
end

end
