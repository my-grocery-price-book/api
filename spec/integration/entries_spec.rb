require 'integration_helper'

describe '/entries', type: :integration do
  it 'create new entry' do
    post '/entries', date_on: Date.today.to_s, store: 'Pick n Pay', location: 'Canal Walk', brand: 'Coke',
                     generic_name: 'Soda', quanity: '2', quanity_unit: 'Liters', total_price: '13.99'
    expect(last_response.status).to eq(201)
  end

  it 'create new entry is thread safe' do
    threads = (1..24).map do |i|
      Thread.new(i) do |i|
        post '/entries', date_on: (Date.today + i).to_s, store: 'Pick n Pay', location: 'Canal Walk', brand: 'Coke',
         generic_name: 'Soda', quanity: '2', quanity_unit: 'Liters', total_price: '13.99'
      end
    end
    threads.each {|t| t.join}

    get '/entries'
    expect(last_response.body).to include((Date.today + 1).to_s)
    expect(last_response.body).to include((Date.today + 12).to_s)
  end

  it 'create new entry is process safe' do
    (1..24).map do |i|
      Process.fork do
        post '/entries', date_on: (Date.today + i).to_s, store: 'Pick n Pay', location: 'Canal Walk', brand: 'Coke',
             generic_name: 'Soda', quanity: '2', quanity_unit: 'Liters', total_price: '13.99'
      end
    end
    Process.wait

    get '/entries'
    expect(last_response.body).to include((Date.today + 1).to_s)
    expect(last_response.body).to include((Date.today + 12).to_s)
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
    expect(last_response.body).to include('Pick n Pay')
    expect(last_response.body).to include('Shoprite')
  end
end
