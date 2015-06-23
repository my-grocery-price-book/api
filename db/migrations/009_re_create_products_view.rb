Sequel.migration do
  up do
    drop_view(:products)
    DB.create_view(:products, DB[:price_entries].distinct.select(:product_brand_name, :package_unit))
  end

  down do
    drop_view(:products)
    DB.create_view(:products, DB[:price_entries].distinct.select(:generic_name, :package_unit))
  end
end
