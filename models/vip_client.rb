class VipClient
  include ::DataMapper::Resource
  property :id, Serial
  property :name, Text
  property :birthday, Date
  property :email, Text
  has n, :invitations

 # DataMapper.setup(:default, 'postgres://david:123456@localhost/usersmareta')


 # DataMapper.finalize.auto_upgrade!

  def self.insert_into_database(list_clients)
  	list_clients.each do |client|
  		VipClient.create(client)
  	end
  end


end


