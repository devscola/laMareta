
require 'smarter_csv'

module CsvToDatabase
  
  def csv_to_database filename
    
    options = {:col_sep => ',', :row_sep => :auto}
    parsed_csv = SmarterCSV.process(filename)
    #  do |array|
    #   puts array
    #   User.create( array.first )
    # end
    # puts parsed_csv
    # puts User.all
    # # open(filename, "r") { |io| 
    #   puts 'file contents'
    #   puts io.read
    #   puts 'end of file contents'
    # }
  end

end