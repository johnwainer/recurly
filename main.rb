require 'sinatra'
require 'json'
require_relative './app/validators/tin_validator'

class TINAPI < Sinatra::Base
  post '/validate_tin' do
    data = JSON.parse(request.body.read)
    country = data['country']
    number = data['number']

    validator = TINValidator.new(country, number)
    result = validator.validate

    content_type :json
    result.to_json
  end

  run! if app_file == $0
end