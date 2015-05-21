require 'roo'
require 'spec_helper'
require './helpers/excel_parser'

describe ExcelParser do
  describe "#parse" do
    it "creates a collection of clients from an xlsx file" do
      file_path = File.join(File.dirname(__FILE__), 'fixtures', 'databasetest.xlsx')
      expect(ExcelParser.parse(file_path)).to eq(
      	[
      		{name: "David", birthday: "13-12-1985", email: "daviddsrperiodismo@gmail.com"},
      		{name: "Javier", birthday: "05-05-1985", email: "javier@gmail.com"}
      		])
    end
    it "creates a collection of clients from an xls file" do
      file_path = File.join(File.dirname(__FILE__), 'fixtures', 'databasetest.xls')
      expect(ExcelParser.parse(file_path)).to eq(
        [
          {name: "David", birthday: "13-12-1985", email: "daviddsrperiodismo@gmail.com"},
          {name: "Javier", birthday: "05-05-1985", email: "javier@gmail.com"}
          ])
    end
    it "raises an error when excel email format is not correct" do
      file_path = File.join(File.dirname(__FILE__), 'fixtures', 'databasetest_bad_email.xlsx')
      expect{ExcelParser.parse(file_path)}.to raise_error(EmailError)
    end
    it "raises an error when excel date format is not correct" do
      file_path = File.join(File.dirname(__FILE__), 'fixtures', 'databasetest_bad_date.xlsx')
      expect{ExcelParser.parse(file_path)}.to raise_error(DateFormatError)
    end
    it "raises an error when excel name format is not correct" do
      file_path = File.join(File.dirname(__FILE__), 'fixtures', 'databasetest_bad_name.xlsx')
      expect{ExcelParser.parse(file_path)}.to raise_error(NameError)
    end
  end
  # describe "#validates_format" do
  #   it "validates the dates format in excel file" do
  #     file_path = File.join(File.dirname(__FILE__), 'fixtures', 'databasetest.xlsx')
  #     excel_file = ExcelParser.create_roo_object(file_path)
  #     expect{validates_format(excel_file)}.not_to raise_error
  #   end
  #   context "#valid_email? wrong" do
  #     it "raises an error when excel email format is not correct" do
  #       file_path = File.join(File.dirname(__FILE__), 'fixtures', 'databasetest_bad_email.xlsx')
  #       excel_file = ExcelParser.create_roo_object(file_path)
  #       expect{validates_format(excel_file)}.to raise_error(EmailError)
  #     end
  #   end
  #   context "#valid_name? wrong" do
  #     it "raises an error when excel name format is not correct" do
  #       file_path = File.join(File.dirname(__FILE__), 'fixtures', 'databasetest_bad_name.xlsx')
  #       excel_file = ExcelParser.create_roo_object(file_path)
  #       expect{validates_format(excel_file)}.to raise_error(NameError)
  #     end
  #   end
  #   context "#valid_date? wrong" do
  #     it "raises an error when excel date format is not correct" do
  #       file_path = File.join(File.dirname(__FILE__), 'fixtures', 'databasetest_bad_date.xlsx')
  #       excel_file = ExcelParser.create_roo_object(file_path)
  #       expect{validates_format(excel_file)}.to raise_error(DateFormatError)    
  #     end
  #   end
  # end
end
