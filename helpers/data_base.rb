
require 'data_mapper'
require 'dm-postgres-adapter'
require './models/vip_client.rb'


# class DB
#   def self.initialize
#   set :environment, :development do
# 	  DataMapper.setup(:default, 'postgres://david:123456@localhost/usersmareta')
#   end
#   set :environment, :production do
#     DataMapper.setup(:default, ENV['DATABASE_URL'])
#   end
# 	DataMapper.finalize.auto_upgrade!
#   end
# end
