require 'integration_helper'

describe '/test_airbrake', type: :integration do
  it '500 error' do
    get '/test_airbrake'
    expect(last_response.status).to eq(500)
    expect(last_response.body).to eq('{"error":"Test Airbrake"}')
  end
end
