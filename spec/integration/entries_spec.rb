require 'integration_helper'

describe '/entries', type: :integration do
  it 'wont allow post if no api_key' do
    temp_params = price_params
    temp_params.delete(:api_key)
    post '/entries', temp_params
    expect(last_response.status).to eq(400)
  end

  it 'wont allow post if invalid api_key' do
    post '/entries', price_params.merge(api_key: '0')
    expect(last_response.status).to eq(401)
  end

  it 'create new entry' do
    post '/entries', price_params
    expect(last_response.status).to eq(201)
  end

  it 'creates multiple' do
    post '/entries', price_params
    post '/entries', price_params
    expect(last_response.status).to eq(201)
  end

  it 'lists new created entry' do
    post '/entries', price_params(store: 'Pick n Pay')
    get '/entries'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Pick n Pay')
  end

  it 'list multiple of same item' do
    post '/entries', price_params(store: 'Pick n Pay')
    post '/entries', price_params(store: 'Shoprite')
    get '/entries'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Pick n Pay')
    expect(last_response.body).to include('Shoprite')
  end
end
