require 'unit_helper'
require 'active_support/core_ext/hash/except'

require './app/commands/user/get_shopper_id_for_key'

describe User::GetShopperIdForKey do
  let(:subject) { User::GetShopperIdForKey }

  before :each do
    DB[:users].truncate
  end

  describe 'execute' do
    def execute_command(*args)
      command = subject.new(*args)
      command.execute
    end

    it 'returns id for api_key'  do
      shopper_id = DB[:users].insert(api_key: 'grant')
      expect(execute_command(api_key: 'grant')).to eq(shopper_id)
    end

    it 'returns nil for unknown api_key'  do
      DB[:users].insert(api_key: 'grant')
      expect(execute_command(api_key: 'test')).to be_nil
    end
  end
end
