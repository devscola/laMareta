require 'sinatra'

get '/' do
	erb :upload
end

post '/upload' do
	File.open('uploads/' + params['myfile'][:filename], "w") do |f|
    f.write(params['myfile'][:tempfile].read)
	end
return "The file was successfully uploaded!"
end