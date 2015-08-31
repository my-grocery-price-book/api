require 'integration_helper'

describe '/:region/entries', type: :integration do
  it 'wont allow post if no api_key' do
    temp_params = price_params
    temp_params.delete(:api_key)
    post '/za-wc/entries', temp_params
    expect(status: last_response.status,
           body: last_response.body).to eq(status: 401, body: 'invalid api_key')
  end

  it 'wont allow post if invalid api_key' do
    post '/za-wc/entries', price_params.merge(api_key: '0')
    expect(status: last_response.status,
           body: last_response.body).to eq(status: 401, body: 'invalid api_key')
  end

  it 'create new entry' do
    post '/za-wc/entries', price_params
    expect(status: last_response.status,
           body: last_response.body).to eq(status: 201, body: '{"success":true}')
  end

  it 'creates multiple in same region' do
    post '/za-wc/entries', price_params
    post '/za-wc/entries', price_params
    expect(status: last_response.status,
           body: last_response.body).to eq(status: 201, body: '{"success":true}')
  end

  it 'lists new created entry' do
    post '/za-ec/entries', price_params(store: 'Shoprite')
    post '/za-wc/entries', price_params(store: 'Pick n Pay')
    get '/za-wc/entries'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Pick n Pay')
    expect(last_response.body).to_not include('Shoprite')
  end

  it 'list multiple of same item' do
    post '/za-wc/entries', price_params(store: 'Pick n Pay')
    post '/za-wc/entries', price_params(store: 'Shoprite')
    get '/za-wc/entries'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Pick n Pay')
    expect(last_response.body).to include('Shoprite')
  end
end
