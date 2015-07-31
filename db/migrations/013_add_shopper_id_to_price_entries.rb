Sequel.migration do
  up do
    add_column :price_entries, :shopper_id, Integer
  end

  down do
    drop_column :price_entries, :shopper_id
  end
end
