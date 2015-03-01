require 'spec_helper'

describe 'Migrations' do
  describe 'rebuilds' do
    it 'empty array by default'  do
      Sequel::Migrator.apply(DB, './db/migrations')
      Sequel::Migrator.apply(DB, './db/migrations', 0)
      Sequel::Migrator.apply(DB, './db/migrations')
      Sequel::Migrator.apply(DB, './db/migrations', 0)
      Sequel::Migrator.apply(DB, './db/migrations')
    end
  end
end
