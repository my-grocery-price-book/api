Sequel.migration do
  up do
    add_column :price_entries, :sets_of, :integer, default: 1, null: false
  end

  down do
    drop_column :price_entries, :sets_of
  end
end
