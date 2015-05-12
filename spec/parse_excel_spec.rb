
require 'roo'

require 'spec_helper'
require './helpers/parse_excel.rb'



describe ExcelParser do
  describe "#parse" do
    it "creates an array of hashes from an excel file" do
      file_path = File.join(File.dirname(__FILE__), 'fixtures', 'databasetest.xlsx')
      excel = Roo::Excelx.new(file_path)
      expect(ExcelParser.parse(excel)).to eq(
      	[
      		{name: "David", birthday: "13-12-1985", email: "daviddsrperiodismo@gmail.com"},
      		{name: "Javier", birthday: "05-05-1985", email: "javier@gmail.com"}
      		])            
    end
  end
end
