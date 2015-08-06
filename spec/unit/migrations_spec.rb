require 'unit_helper'

describe 'Migrations' do
  describe 'rebuilds' do
    it 'allows to go up and down'  do
      Sequel::Migrator.apply(DB, './db/migrations')
      Sequel::Migrator.apply(DB, './db/migrations', 0)
      Sequel::Migrator.apply(DB, './db/migrations')
      Sequel::Migrator.apply(DB, './db/migrations', 0)
      Sequel::Migrator.apply(DB, './db/migrations')
    end
  end
end
