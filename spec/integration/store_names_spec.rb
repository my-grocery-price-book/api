require 'integration_helper'

describe '/:region/store_names', type: :integration do
  it 'successfull response' do
    get '/za-wc/store_names'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('[]')
  end

  it 'successfull response' do
    post '/za-wc/entries', price_params(store: 'Pick n Pay')
    expect(last_response.status).to eq(201)
    get '/za-wc/store_names'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('["Pick n Pay"]')
  end
end
