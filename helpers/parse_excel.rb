require 'roo'

class ExcelParser
  def self.parse(excel_file)
    list_clients = []
    3.upto(excel_file.last_row) do |line|
      data_client = {}
      data_client[:name] = excel_file.cell(line,'A')
      data_client[:birthday] = excel_file.cell(line,'B')
      data_client[:email] = excel_file.cell(line, 'C')
      list_clients << data_client
    end
    list_clients
  end
end