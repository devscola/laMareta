require 'roo'

class ExcelParser
  LETTERS = /[a-zA-Z]+/
  EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  DATE_FORMAT = "%d-%m-%Y"

  class << self
    def parse(file_name)
      ExcelParser.validates(file_name)
      if file_name =~ /xlsx$/
        excel_file = Roo::Excelx.new(file_name)
      else
        excel_file = Roo::Excel.new(file_name)
      end
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
      if file_name =~ /xlsx$/
        excel_file = Roo::Excelx.new(file_name)
      else
        excel_file = Roo::Excel.new(file_name)
      end
      result = 3.upto(excel_file.last_row).all? { |line| 
        valid_name?(excel_file.cell(line,'A')) && valid_date?(excel_file.cell(line,'B')) && valid_email?(excel_file.cell(line, 'C'))
      }
      raise FormatError.new "Dates format not valid" unless result
      result
    end

    def valid_date?(str)
      Date.strptime(str, DATE_FORMAT) rescue false
    end

    def valid_name?(string)
      string[LETTERS] == string
    end

    def valid_email?(string)
      string[EMAIL] == string
    end
  end
end

class FormatError < StandardError

end
