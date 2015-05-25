class VipClient
  include ::DataMapper::Resource
  property :id, Serial
  property :name, Text
  property :birthday, Date
  property :email, Text
  

  def self.insert_into_database(list_clients)
  	list_clients.each do |client|
  		VipClient.create(client) if VipClient.exists?(client) == false
  	end
  end

  private

  def self.exists?(client)
    VipClient.count(:name=> client[:name], :birthday=> client[:birthday], :email=> client[:email]) > 0
  end
end
