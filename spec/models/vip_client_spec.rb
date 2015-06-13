require 'spec_helper'
require 'data_mapper'
require File.join(File.dirname(__FILE__), '..', '..', 'models', 'vip_client.rb')

describe VipClient do
  before {
    DataMapper.setup(:default, 'postgres://postgres@localhost/usersmareta')
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
    it "updates the database with the new vip clients except the vip clients that already exists" do
      list_clients = [
        {name: "David", birthday: "13-12-1985", email: "daviddsrperiodismo@gmail.com"},
        {name: "Javier", birthday: "05-05-1985", email: "javier@gmail.com"}
      ]
      list_clients2 = [
        {name: "David", birthday: "13-12-1985", email: "daviddsrperiodismo@gmail.com"},
        {name: "Javier", birthday: "05-05-1985", email: "javier@gmail.com"},
        {name: "Paco", birthday: "02-08-1985", email: "pacofiestas@gmail.com"}
      ]
      VipClient.insert_into_database(list_clients)
      VipClient.insert_into_database(list_clients2)
      expect(VipClient.all.count).to eq(3)
    end
    it "updates the info data of a client if already exists" do
      list_clients = [
        {name: "David", birthday: "13-12-1985", email: "daviddsrperiodismo@gmail.com"},
        {name: "Javier", birthday: "05-05-1985", email: "javier@gmail.com"}
      ]
      list_clients2 = [
        {name: "Pepe", birthday: "13-12-1985", email: "daviddsrperiodismo@gmail.com"},
        {name: "Javier", birthday: "05-05-1985", email: "javier@gmail.com"},
        {name: "Paco", birthday: "02-08-1985", email: "pacofiestas@gmail.com"}
      ]
      VipClient.insert_into_database(list_clients)
      VipClient.insert_into_database(list_clients2)
      expect(VipClient[0].name).to eq("Pepe")
    end
  end
end
