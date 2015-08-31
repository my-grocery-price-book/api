Sequel.migration do
  up do
    drop_column :price_entries, :package_size
    add_column :price_entries, :package_size, BigDecimal
  end

  down do
    drop_column :price_entries, :package_size
    add_column :price_entries, :package_size, Integer
  end
end
