require 'integration_helper'

describe '/ping', type: :integration do
  it 'returns pong' do
    get '/ping', price_params
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('pong')
  end
end
