class VipClient
  include ::DataMapper::Resource
  property :id, Serial
  property :name, Text
  property :birthday, Date
  property :email, Text
  

  def self.insert_into_database(list_clients)
  	list_clients.each do |client|
      VipClient.create(client) unless exists?(client)
      if client[:out] == true
        delete(client)
      else
        update(client)
      end   
  	end
  end

  private

  def self.delete(client)
    client_email = client[:email]
    not_client_anymore = VipClient.first(:conditions => { :email => client_email })
    not_client_anymore.destroy
  end

  def self.update(client)
    old_client = find_old_data_from_this(client)
    old_client.update(:name => client[:name], :birthday => client[:birthday], :email => client[:email])
  end

  def self.find_old_data_from_this(client)
    client_email = client[:email]
    old_client = VipClient.first(:conditions => { :email => client_email })
    old_client
  end

  def self.exists?(client)
    VipClient.count(:email=> client[:email]) > 0
  end
end
