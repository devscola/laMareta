require 'roo'

class ExcelParser
  LETTERS = /[a-zA-Z]+/
  EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  DATE_FORMAT = "%d-%m-%Y"
  START_READING_LINE = 3

  class << self
    def parse(file_name)
      excel_file = create_roo_object(file_name)
      validates_format(excel_file)
      fulfill_db_with(excel_file)     
    end

    private

    def fulfill_db_with(excel_file)
      list_clients = []
      START_READING_LINE.upto(excel_file.last_row) do |line|
        data_client = {}
        data_client[:name] = excel_file.cell(line,'A')
        data_client[:birthday] = excel_file.cell(line,'B')
        data_client[:email] = excel_file.cell(line, 'C')
        
        data_client[:out] = true if excel_file.cell(line, 'D') == "out"
        list_clients << data_client
      end
      list_clients
    end

    def create_roo_object(file_name)
      if file_name =~ /xlsx$/
        excel_file = Roo::Excelx.new(file_name)
      else
        excel_file = Roo::Excel.new(file_name)
      end
    end

    def validates_format(excel_file)  
      result = START_READING_LINE.upto(excel_file.last_row).all? do |line|
        name = excel_file.cell(line,'A')
        date = excel_file.cell(line,'B')
        email = excel_file.cell(line, 'C')
        check_name!(name)
        check_date!(date)
        check_email!(email)
      end
      result
    end

    def check_date!(string)
      begin
        Date.strptime(string, DATE_FORMAT)
      rescue ArgumentError 
        raise DateFormatError.new "Date format not valid" 
      end
    end

    def check_name!(string)
      raise NameError.new "Name format not valid" unless string[LETTERS] == string
    end 

    def check_email!(string)
      raise EmailError.new "email format not valid" unless string[EMAIL] == string
    end
    
  end
    class FormatError < StandardError

    end

    class DateFormatError < StandardError

    end

    class NameError < StandardError

    end

    class EmailError < StandardError

    end


end

