require 'sinatra'



# HELPERS

require './helpers/excel_parser'
# MODELS


require './helpers/data_base'



DB.initialize

class LaMareta < Sinatra::Application

  get '/' do
    erb :upload
  end

  post '/upload' do
    filename = 'uploads/' + params['birthdayFile'][:filename]

      File.open(filename, "w") do |f|
        f.write(params['birthdayFile'][:tempfile].read)
      end
  # if filename =~ /xlsx$/
  #   excel = Roo::Excelx.new(filename)
  # else
  #   excel = Roo::Excel.new(filename)
  # end
    list_clients = ExcelParser.parse(filename)
    VipClient.insert_into_database(list_clients)
    redirect '/uploaded'
  end

  get '/uploaded' do
    erb :uploaded_file
  end

end
