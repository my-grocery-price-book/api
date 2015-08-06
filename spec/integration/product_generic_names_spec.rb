require 'integration_helper'

describe '/:region/product_generic_names', type: :integration do
  it 'successfull response' do
    get '/za-wc/product_generic_names'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('[]')
  end

  it 'successfull response' do
    post '/za-wc/entries', price_params(generic_name: 'Soda')
    expect(last_response.status).to eq(201)
    get '/za-wc/product_generic_names'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('["Soda"]')
  end
end
