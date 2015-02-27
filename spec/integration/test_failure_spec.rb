require 'integration_helper'

describe '/test_failure', type: :integration do
  it '500 error' do
    get '/test_failure'
    expect(last_response.status).to eq(500)
    expect(last_response.body).to eq('{"error":"Test Failure"}')
  end
end
