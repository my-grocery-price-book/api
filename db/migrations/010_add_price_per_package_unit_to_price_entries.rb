Sequel.migration do
  up do
    add_column :price_entries, :price_per_package_unit, Float
  end

  down do
    drop_column :price_entries, :price_per_package_unit
  end
end
