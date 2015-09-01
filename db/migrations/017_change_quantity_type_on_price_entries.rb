Sequel.migration do
  up do
    set_column_type :price_entries, :quantity, Integer
  end

  down do
    set_column_type :price_entries, :quantity, Float
  end
end
