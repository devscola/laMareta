
require 'roo'

require 'spec_helper'
require './helpers/excel_parser'



describe ExcelParser do
  describe "#parse" do
    it "creates a collection of clients from an xlsx file" do
      file_path = File.join(File.dirname(__FILE__), 'fixtures', 'databasetest.xlsx')
      #excel = Roo::Excelx.new(file_path)
      expect(ExcelParser.parse(file_path)).to eq(
      	[
      		{name: "David", birthday: "13-12-1985", email: "daviddsrperiodismo@gmail.com"},
      		{name: "Javier", birthday: "05-05-1985", email: "javier@gmail.com"}
      		])            
    end
  end
  describe "#validates" do
    it "validates the dates format in excel file" do
      file_path = File.join(File.dirname(__FILE__), 'fixtures', 'databasetest.xlsx')
      #allow(Roo::Excelx).to receive(:new).with(file_path).and_return(:excel)
      expect{ExcelParser.validates(file_path)}.not_to raise_error
    end
    it "raises an error when excel format is not correct" do
      file_path = File.join(File.dirname(__FILE__), 'fixtures', 'databasetest_bad_format.xlsx')
      expect{ExcelParser.validates(file_path)}.to raise_error(FormatError)
    end
  end
end
