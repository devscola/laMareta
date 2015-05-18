require 'spec_helper'
require 'data_mapper'



require File.join(File.dirname(__FILE__), '..', '..', 'models', 'vip_client.rb')
#File.join(File.dirname(__FILE__), 'fixtures', 'databasetest.xlsx')




describe VipClient do
  before {
    DataMapper.setup(:default, 'postgres://david:123456@localhost/usersmareta')
    DataMapper.finalize.auto_upgrade!
  }
  after {
    clients_database = VipClient.all
    clients_database.each { |client| client.destroy }
  }
  describe "#insert_into_database" do
    it "inserts clients into database from an array of hashes" do
      list_clients = [
        {name: "David", birthday: "13-12-1985", email: "daviddsrperiodismo@gmail.com"},
        {name: "Javier", birthday: "05-05-1985", email: "javier@gmail.com"}
      ]
      VipClient.insert_into_database(list_clients)
      expect(VipClient.all.count).to eq(2)
    end
  end
  describe "VipClient properties" do
    it "a client in database has 3 propperties: name, email and birthday" do
      list_clients = [
        {name: "David", birthday: "13-12-1985", email: "daviddsrperiodismo@gmail.com"}
      ]
      VipClient.insert_into_database(list_clients)
      client = VipClient.first
      expect(client.name).to eq("David")
      expect(client.birthday.to_s).to eq("1985-12-13")
      expect(client.email).to eq("daviddsrperiodismo@gmail.com")      
    end
  end
end