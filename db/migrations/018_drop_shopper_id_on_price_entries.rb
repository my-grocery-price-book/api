Sequel.migration do
  up do
    drop_column :price_entries, :shopper_id
  end

  down do
    add_column :price_entries, :shopper_id, Integer
  end
end
