require 'integration_helper'

describe 'The PriceBook App', type: :integration do
  it 'gets the auto generated docs' do
    get '/swagger_doc'
    expect(last_response.status).to eq(200)
  end
end
