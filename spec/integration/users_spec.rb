require 'integration_helper'

describe '/users', type: :integration do
  it 'can create a new user' do
    post '/users', email: 'grant@example.com'
    expect(last_response.status).to eq(201)
    expect(last_response.body).to include('grant@example.com')
  end

  it 'can create a new user with email and shopper_name' do
    post '/users', shopper_name: 'Gman', email: 'grant@example.com'
    expect(last_response.status).to eq(201)
    expect(last_response.body).to include('Gman')
    expect(last_response.body).to include('grant@example.com')
  end
end
