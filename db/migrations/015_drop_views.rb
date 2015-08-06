Sequel.migration do
  up do
    drop_view(:unit_names)
    drop_view(:store_names)
    drop_view(:location_names)
    drop_view(:products)
    drop_view(:product_generic_names)
    drop_view(:product_brand_names)
  end

  down do
    DB.create_view(:location_names, DB[:price_entries].distinct.select(:location))
    DB.create_view(:store_names, DB[:price_entries].distinct.select(:store))
    DB.create_view(:product_brand_names, DB[:price_entries].distinct.select(:product_brand_name))
    DB.create_view(:product_generic_names, DB[:price_entries].distinct.select(:generic_name))
    DB.create_view(:products, DB[:price_entries].distinct.select(:product_brand_name, :package_unit))
    DB.create_view(:unit_names, DB[:price_entries].distinct.select(:package_unit))
  end
end
