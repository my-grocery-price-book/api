require 'integration_helper'

describe '/entries', type: :integration do
  it 'create new entry' do
    post '/entries', date_on: Date.today.to_s, store: 'Pick n Pay', location: 'Canal Walk', product_brand_name: 'Coke',
                     generic_name: 'Soda', package_type: 'Cans', package_size: '340', package_unit: 'ml',
                     package_serves: '1', quanity: '6', quanity_unit: 'Liters', total_price: '38.99'
    expect(last_response.status).to eq(201)
  end

  it 'creates multiple' do
    post '/entries', date_on: Date.today.to_s, store: 'Pick n Pay', location: 'Canal Walk', product_brand_name: 'Coke',
                     generic_name: 'Soda', quanity: '2', quanity_unit: 'Liters', total_price: '13.99'
    post '/entries', date_on: Date.today.to_s, store: 'Shoprite', location: 'Bothasig', product_brand_name: 'Coke',
                     generic_name: 'Soda', quanity: '2', quanity_unit: 'Liters', total_price: '12.99'
    expect(last_response.status).to eq(201)
  end

  it 'lists new created entry' do
    post '/entries', date_on: Date.today.to_s, store: 'Pick n Pay', location: 'Canal Walk', product_brand_name: 'Coke',
                     generic_name: 'Soda', quanity: '2', quanity_unit: 'Liters', total_price: '13.99'
    get '/entries'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Pick n Pay')
  end

  it 'list multiple of same item' do
    post '/entries', date_on: Date.today.to_s, store: 'Pick n Pay', location: 'Canal Walk', product_brand_name: 'Coke',
                     generic_name: 'Soda', quanity: '2', quanity_unit: 'Liters', total_price: '13.99'
    post '/entries', date_on: Date.today.to_s, store: 'Shoprite', location: 'Bothasig', product_brand_name: 'Coke',
                     generic_name: 'Soda', quanity: '2', quanity_unit: 'Liters', total_price: '12.99'
    get '/entries'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Pick n Pay')
    expect(last_response.body).to include('Shoprite')
  end
end
