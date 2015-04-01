require 'sinatra'

get '/' do
	erb :upload
end

post '/upload' do
	File.open('uploads/' + params['birthdayFile'][:filename], "w") do |f|
    f.write(params['birthdayFile'][:tempfile].read)
  end
end
