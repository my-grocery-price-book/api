Sequel.migration do
  up do
    add_column :price_entries, :region, String
    add_index :price_entries, :region
  end

  down do
    drop_column :price_entries, :region
  end
end
