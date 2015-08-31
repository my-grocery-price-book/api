Sequel.migration do
  up do
    drop_column :price_entries, :quantity
    add_column :price_entries, :quantity, Integer
  end

  down do
    drop_column :price_entries, :quantity
    add_column :price_entries, :quantity, Float
  end
end
