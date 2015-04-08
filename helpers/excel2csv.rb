require 'roo'
require 'csv'

module ExcelToCsv

  def self.convert_excel_to_csv(filename, output)
    if filename =~ /xlsx$/
      excel = Roo::Excelx.new(filename)
    else
      excel = Roo::Excel.new(filename)
    end

    File.open(output, "w+") do |file|
      begin
        2.upto(excel.last_row) do |line|
          file.write CSV.generate_line excel.row(line)
        end
      ensure
        file.close
      end
    end

    # filename = 'uploads/filename.csv'
    # p output
    # options = {:col_sep => ',', :row_sep => :auto}
    # n = SmarterCSV.process(filename, options) do |array|
    #   # we're passing a block in, to process each resulting hash / =row (the block takes array of hashes)
    #   # when chunking is not enabled, there is only one hash in each array
    #    MyModel.create( array.first )
    # end
  end

end
