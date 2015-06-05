Sequel.migration do
  up do
    DB.drop_view(:products)
    DB.drop_view(:unit_names)
    rename_column :price_entries, :quanity_unit, :package_unit
    add_column :price_entries, :package_type, String
    add_column :price_entries, :package_size, Integer
    add_column :price_entries, :package_serves, Integer
    drop_column :price_entries, :sets_of
    DB.create_view(:products, DB[:price_entries].distinct.select(:generic_name, :package_unit))
    DB.create_view(:unit_names, DB[:price_entries].distinct.select(:package_unit))
  end

  down do
    DB.drop_view(:unit_names)
    DB.drop_view(:products)
    add_column :price_entries, :sets_of, Integer
    drop_column :price_entries, :package_serves
    drop_column :price_entries, :package_size
    drop_column :price_entries, :package_type
    rename_column :price_entries, :package_unit, :quanity_unit
    DB.create_view(:unit_names, DB[:price_entries].distinct.select(:quanity_unit))
    DB.create_view(:products, DB[:price_entries].distinct.select(:generic_name, :quanity_unit))
  end
end
