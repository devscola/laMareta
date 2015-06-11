module FileUploader
  def create_file(birthdayFile)
    filename = 'uploads/' + birthdayFile  
  end

  def write_file(filename, birthdayFile)
    File.open(filename, "w") do |f|
      f.write(birthdayFile.read)
    end
  end
end
