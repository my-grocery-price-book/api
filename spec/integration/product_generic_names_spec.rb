require 'integration_helper'

describe '/product_generic_names', type: :integration do
  it 'successfull response' do
    get '/product_generic_names'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('[]')
  end

  it 'successfull response' do
    post '/entries', date_on: Date.today.to_s, store: 'Pick n Pay', location: 'Canal Walk', product_brand_name: 'Coke',
                     generic_name: 'Soda', quanity: '2', quanity_unit: 'Liters', total_price: '13.99'
    expect(last_response.status).to eq(201)
    get '/product_generic_names'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('["Soda"]')
  end
end