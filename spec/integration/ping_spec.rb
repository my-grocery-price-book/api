require 'integration_helper'

describe '/ping', type: :integration do
  it 'returns pong' do
    get '/ping', price_params
    expect(status: last_response.status, body: last_response.body).to eq(status: 200, body: '{"pong":true}')
  end
end
