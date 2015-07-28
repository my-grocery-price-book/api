Sequel.migration do
  up do
    rename_column :price_entries, :quanity, :quantity
  end

  down do
    rename_column :price_entries, :quantity, :quanity
  end
end
