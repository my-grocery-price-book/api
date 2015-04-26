require 'integration_helper'

describe '/entries', type: :integration do
  it 'create new entry' do
    post '/entries', price_params
    expect(last_response.status).to eq(201)
  end

  it 'creates multiple' do
    post '/entries', price_params(store: 'Pick n Pay', location: 'Canal Walk', product_brand_name: 'Coke',
                                  quanity: '2', total_price: '13.99')
    post '/entries', price_params(store: 'Shoprite', location: 'Bothasig', product_brand_name: 'Coke',
                                  quanity: '2', total_price: '12.99')
    expect(last_response.status).to eq(201)
  end

  it 'lists new created entry' do
    post '/entries', price_params(store: 'Pick n Pay', location: 'Canal Walk', product_brand_name: 'Coke',
                                  quanity: '2', total_price: '13.99')
    get '/entries'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Pick n Pay')
  end

  it 'list multiple of same item' do
    post '/entries', price_params(store: 'Pick n Pay', location: 'Canal Walk', product_brand_name: 'Coke',
                                  quanity: '2', total_price: '13.99')
    post '/entries', price_params(store: 'Shoprite', location: 'Bothasig', product_brand_name: 'Coke',
                                  quanity: '2', total_price: '12.99')
    get '/entries'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Pick n Pay')
    expect(last_response.body).to include('Shoprite')
  end
end
