require 'unit_helper'
require 'active_support/core_ext/hash/except'

require './app/commands/users/add_command'

describe Users::AddCommand do
  let(:subject) { Users::AddCommand }
  let(:last_entry) { DB[:users].order(:id).last }

  before :each do
    DB[:users].truncate
  end

  describe 'execute' do
    def execute_command(*args)
      command = subject.new(*args)
      command.execute
    end

    it 'saves the entry to storage' do
      execute_command(shopper_name: 'grant', email: 'hello@example.com')
      entry_values = last_entry.except(:id, :api_key, :created_at)
      expect(entry_values).to eq(shopper_name: 'grant',  email: 'hello@example.com')
      expect(last_entry[:created_at]).to be_kind_of(Time)
    end

    it 'returns the saved params with id and api_key' do
      allow(SecureRandom).to receive(:hex) { 'pass' }
      return_values = execute_command(shopper_name: 'test', email: 'mail@example.com')
      expect(return_values).to eq(shopper_name: 'test', email: 'mail@example.com', api_key: 'pass')
    end

    it 'requires email to be unique' do
      execute_command(shopper_name: 'grant', email: 'hello@example.com')
      expect do
        execute_command(shopper_name: 'grant1',  email: 'hello@example.com')
      end.to raise_error(Users::ValidationError, 'email address taken')
    end

    it 'requires shopper_name to be unique' do
      execute_command(shopper_name: 'grant', email: 'hello@example.com')
      expect do
        execute_command(shopper_name: 'grant', email: 'hello1@example.com')
      end.to raise_error(Users::ValidationError, 'shopper name taken')
    end

    it 'allows multiply additions'  do
      execute_command(shopper_name: 'grant', email: 'hello@example.com')
      execute_command(shopper_name: 'grant1',  email: 'hello1@example.com')
      execute_command(shopper_name: 'grant2',  email: 'hello2@example.com')
    end

    it 'allows multiply additions with no shopper name' do
      execute_command(shopper_name: nil,  email: 'hello@example.com')
      execute_command(shopper_name: nil,  email: 'hello1@example.com')
    end
  end
end
