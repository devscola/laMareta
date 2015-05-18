
require 'data_mapper'
require 'dm-postgres-adapter'
require './models/vip_client.rb'
require './models/invitations.rb'

class DB
  def self.initialize
	DataMapper.setup(:default, 'postgres://david:123456@localhost/usersmareta')
	DataMapper.finalize.auto_upgrade!
  end
end