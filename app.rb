ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require 'sinatra/base'
require 'rack-flash'
require 'dm-postgres-adapter'


# HELPERS
require './helpers/excel_parser'
require './helpers/file_uploader'

# MODELS
require './models/vip_client.rb'

include FileUploader

class LaMareta < Sinatra::Base

  enable :sessions
  use Rack::Flash

  configure :development, :test do
    DataMapper.setup(:default, 'postgres://postgres@localhost/usersmareta')
    DataMapper.finalize.auto_upgrade!
  end

  configure :production do
    DataMapper.setup(:default, ENV['DATABASE_URL'])
    DataMapper.finalize.auto_upgrade!
  end


  get '/' do
    erb :upload
  end

  post '/upload' do
    filename = create_file(params['birthdayFile'][:filename])

    write_file(filename, params['birthdayFile'][:tempfile])

    clients_list = ExcelParser.parse(filename)

    VipClient.insert_into_database(clients_list)
    flash[:notice] = "Your database has been updated succesfully" 
    redirect '/'
  end

  get '/uploaded' do
    erb :uploaded_file
  end
end
