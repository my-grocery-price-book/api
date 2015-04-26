require 'integration_helper'

describe '/product_brand_names', type: :integration do
  it 'successfull response' do
    get '/product_brand_names'
    expect(last_response.body).to eq('[]')
    expect(last_response.status).to eq(200)
  end

  it 'successfull response' do
    post '/entries', price_params(product_brand_name: 'Coke')
    expect(last_response.status).to eq(201)
    get '/product_brand_names'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('["Coke"]')
  end
end
