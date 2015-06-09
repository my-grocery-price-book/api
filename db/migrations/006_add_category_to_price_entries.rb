Sequel.migration do
  up do
    add_column :price_entries, :category, String
  end

  down do
    drop_column :price_entries, :category
  end
end
