ENV['RACK_ENV'] ||= 'development'
 
require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require 'sinatra/base'
require 'dm-postgres-adapter'


# HELPERS
require './helpers/excel_parser'

# MODELS
require './models/vip_client.rb'
#require './helpers/data_base'
#DB.initialize



class LaMareta < Sinatra::Base

  configure :development do 
    DataMapper.setup(:default, 'postgres://david:123456@localhost/usersmareta')
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
    filename = 'uploads/' + params['birthdayFile'][:filename]

    File.open(filename, "w") do |f|
      f.write(params['birthdayFile'][:tempfile].read)
    end

    clients_list = ExcelParser.parse(filename)
    VipClient.insert_into_database(clients_list)
    redirect '/uploaded'
  end

  get '/uploaded' do
    erb :uploaded_file
  end
end
