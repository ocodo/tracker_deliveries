require 'sinatra'
require 'json'

def status_message id
  STDERR.puts '<== requested =============================================================================>'
  STDERR.puts "- Project ID: #{id}"
  STDERR.puts "- API Token: #{request.env['HTTP_X_TRACKERTOKEN']}"
  STDERR.puts '<==========================================================================================>'
end

stories = [
  {id: '123456', name: 'Story one'},
  {id: '654321', name: 'Story two'}
]

get '/projects/403/stories' do
  status_message 403
  403
end

get '/projects/404/stories' do
  status_message 404
  404
end

get '/projects/1234/stories' do
  status_message 1234
  stories.to_json
end
