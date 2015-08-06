require 'integration_helper'

describe '/:region/products', type: :integration do
  it 'lists new created entry' do
    post '/za-wc/entries', price_params(store: 'Pick n Pay', location: 'Canal Walk', product_brand_name: 'Coke',
                                        quantity: '2', total_price: '13.99')
    get '/za-wc/products'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Pick n Pay')
  end

  it 'list multiple of same item' do
    post '/za-wc/entries', price_params(store: 'Pick n Pay', location: 'Canal Walk', product_brand_name: 'Coke',
                                        quantity: '2', total_price: '13.99')
    post '/za-wc/entries', price_params(store: 'Shoprite', location: 'Bothasig', product_brand_name: 'Bread',
                                        quantity: '2', total_price: '12.99')
    get '/za-wc/products'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Pick n Pay')
    expect(last_response.body).to include('Shoprite')
  end

  it 'list searched item' do
    post '/za-wc/entries', price_params(store: 'Pick n Pay', location: 'Canal Walk', product_brand_name: 'Coke',
                                        quantity: '2', total_price: '13.99')
    post '/za-wc/entries', price_params(store: 'Shoprite', location: 'Bothasig', product_brand_name: 'Bread',
                                        quantity: '2', total_price: '12.99')
    get '/za-wc/products', term: 'Bread'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Shoprite')
    expect(last_response.body).to_not include('Pick n Pay')
  end
end
