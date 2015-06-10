Sequel.migration do
  up do
    drop_column :price_entries, :package_type
  end

  down do
    add_column :price_entries, :package_type, String
  end
end
