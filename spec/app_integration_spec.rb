require File.join(File.dirname(__FILE__), '..', 'app.rb')
require 'spec_helper'
require 'capybara'
require 'capybara/rspec'
Capybara.app = LaMareta

describe "Updating Vip customers database", :type => :feature do
  before {
    DataMapper.setup(:default, 'postgres://postgres@localhost/usersmareta')
    DataMapper.finalize.auto_upgrade!
  }
  after {
    clients_database = VipClient.all
    clients_database.each { |client| client.destroy }
  }
  it "Uploads succesfully an excel file with Vip customers data birhtday" do
    visit '/'
    attach_file('birthdayFile', 'spec/fixtures/databasetest.xlsx')
    click_button 'Upload_excel'
    expect(page.status_code).to eq(200)
    expect(VipClient.all.count).to eq(2)
  end
end
