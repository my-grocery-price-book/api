Sequel.migration do
  up do
    drop_column :price_entries, :package_serves
  end

  down do
    add_column :price_entries, :package_serves, Integer
  end
end
