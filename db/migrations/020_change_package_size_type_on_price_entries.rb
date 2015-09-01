Sequel.migration do
  up do
    set_column_type :price_entries, :package_size, Float
  end

  down do
    set_column_type :price_entries, :package_size, BigDecimal
  end
end
