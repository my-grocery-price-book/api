Sequel.migration do
  up do
    DB.create_view(:brand_names, DB[:price_entries].distinct.select(:brand))
    DB.create_view(:location_names, DB[:price_entries].distinct.select(:location))
    DB.create_view(:product_names, DB[:price_entries].distinct.select(:name))
    DB.create_view(:products, DB[:price_entries].distinct.select(:name, :quanity_unit))
    DB.create_view(:store_names, DB[:price_entries].distinct.select(:store))
    DB.create_view(:unit_names, DB[:price_entries].distinct.select(:quanity_unit))
  end

  down do
    drop_view(:unit_names)
    drop_view(:store_names)
    drop_view(:products)
    drop_view(:product_names)
    drop_view(:location_names)
    drop_view(:brand_names)
  end
end
