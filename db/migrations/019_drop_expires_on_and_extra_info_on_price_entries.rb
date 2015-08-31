Sequel.migration do
  up do
    drop_column :price_entries, :expires_on
    drop_column :price_entries, :extra_info
  end

  down do
    add_column :price_entries, :extra_info, String
    add_column :price_entries, :expires_on, Date
  end
end
