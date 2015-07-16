require 'integration_helper'

describe '/product_brand_names', type: :integration do
  it 'responds when no names' do
    get '/product_brand_names'
    expect(last_response.body).to eq('[]')
    expect(last_response.status).to eq(200)
  end

  it 'responds when one product_brand_name' do
    post '/entries', price_params(product_brand_name: 'Coke')
    expect(last_response.status).to eq(201)
    get '/product_brand_names'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('["Coke"]')
  end

  it 'responds when searching' do
    post '/entries', price_params(product_brand_name: 'Coke')
    post '/entries', price_params(product_brand_name: 'Bread')
    expect(last_response.status).to eq(201)
    get '/product_brand_names', term: 'B'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('["Bread"]')
  end
end
