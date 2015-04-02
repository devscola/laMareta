
require 'smarter_csv'

module CsvToDatabase
  
  def csv_to_database
    filename = 'uploads/filename.csv'
    options = {:col_sep => ',', :row_sep => :auto}
    parsed_csv = SmarterCSV.process(filename) do |array|
      puts array
      MyModel.create( array.first )
    end
    # open(filename, "r") { |io| 
    #   puts 'file contents'
    #   puts io.read
    #   puts 'end of file contents'
    # }
  end

end