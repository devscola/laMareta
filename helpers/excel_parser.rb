require 'roo'

class ExcelParser
  class << self
    def parse(file_name)
      ExcelParser.validates(file_name)
      excel_file = Roo::Excelx.new(file_name)
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

    def validates(file_name)
      excel_file = Roo::Excelx.new(file_name)
      result = 3.upto(excel_file.last_row).all? { |line| 
        valid_name?(excel_file.cell(line,'A')) && valid_date?(excel_file.cell(line,'B'), "%d-%m-%Y") && valid_email?(excel_file.cell(line, 'C'))
      }
      raise FormatError.new "Excel format not valid" unless result
      result
    end

    def valid_date?(str, format="%d/%m/%Y")
      Date.strptime(str,format) rescue false
    end

    def valid_name?(string)
      string[/[a-zA-Z]+/] == string
    end

    def valid_email?(string)
      string[/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i] == string
    end
  end
end

class FormatError < StandardError

end
