require 'integration_helper'

describe '/:region/unit_names', type: :integration do
  it 'successfull response' do
    get '/za-wc/unit_names'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('[]')
  end

  it 'successfull response' do
    post '/za-wc/entries', price_params(package_unit: 'Liters')
    expect(last_response.status).to eq(201)
    get '/za-wc/unit_names'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('["Liters"]')
  end
end
