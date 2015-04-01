require 'roo'
require 'csv'

module ExcelToCsv

  def self.convert_excel_to_csv(filename)
    if filename =~ /xlsx$/
      excel = Roo::Excelx.new(filename)
    else
      excel = Roo::Excel.new(filename)
    end

    output = File.new("uploads/filename.csv", "w+")

    1.upto(excel.last_row) do |line|
      output.write CSV.generate_line excel.row(line)
    end
    
  end
end