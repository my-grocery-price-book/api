require 'integration_helper'

describe '/location_names', type: :integration do
  it 'successfull response' do
    get '/location_names'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('[]')
  end

  it 'successfull response' do
    post '/entries', price_params(location: 'Canal Walk')
    expect(last_response.status).to eq(201)
    get '/location_names'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('["Canal Walk"]')
  end
end
