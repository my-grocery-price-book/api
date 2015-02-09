require 'spec_helper'

require './app/models/price_entry/repo'
require 'rack/test'

describe 'The PriceBook App' do
  include Rack::Test::Methods
  before :each do
    PriceEntry::Repo.instance.reset
  end

  def app
    Rack::Builder.parse_file('./config.ru').first
  end

  it 'gets the auto generated docs' do
    get '/swagger_doc'
    expect(last_response.status).to eq(200)
  end

  it 'create new entry' do
    post '/entries', date_on: Date.today.to_s, store: 'Pick n Pay', location: 'Canal Walk', brand: 'Coke',
                     generic_name: 'Soda', quanity: '2', quanity_unit: 'Liters', total_price: '13.99'
    expect(last_response.status).to eq(201)
  end

  it 'creates multiple' do
    post '/entries', date_on: Date.today.to_s, store: 'Pick n Pay', location: 'Canal Walk', brand: 'Coke',
                     generic_name: 'Soda', quanity: '2', quanity_unit: 'Liters', total_price: '13.99'
    post '/entries', date_on: Date.today.to_s, store: 'Shoprite', location: 'Bothasig', brand: 'Coke',
                     generic_name: 'Soda', quanity: '2', quanity_unit: 'Liters', total_price: '12.99'
    expect(last_response.status).to eq(201)
  end

  it 'lists new created entry' do
    post '/entries', date_on: Date.today.to_s, store: 'Pick n Pay', location: 'Canal Walk', brand: 'Coke',
                     generic_name: 'Soda', quanity: '2', quanity_unit: 'Liters', total_price: '13.99'
    get '/entries'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Pick n Pay')
  end

  it 'list multiple of same item' do
    post '/entries', date_on: Date.today.to_s, store: 'Pick n Pay', location: 'Canal Walk', brand: 'Coke',
                     generic_name: 'Soda', quanity: '2', quanity_unit: 'Liters', total_price: '13.99'
    post '/entries', date_on: Date.today.to_s, store: 'Shoprite', location: 'Bothasig', brand: 'Coke',
                     generic_name: 'Soda', quanity: '2', quanity_unit: 'Liters', total_price: '12.99'
    get '/entries'
    expect(last_response.status).to eq(200)
    puts last_response.body
    expect(last_response.body).to include('Pick n Pay')
    expect(last_response.body).to include('Shoprite')
  end
end
