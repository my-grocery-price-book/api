require 'spec_helper'

require './app/models/price_entry/repo'

describe PriceEntry::Repo do
  subject { PriceEntry::Repo.instance }

  describe 'find_or_create_by_name_and_unit' do
    it 'creates a new price_entry' do
      item = subject.find_or_create_by_name_and_unit(name: 'Soda', unit: 'Liters')
      expect(item).to be_kind_of(PriceEntry::Item)
      expect([item.name, item.unit]).to eq(['Soda', 'Liters'])
    end
  end
end
