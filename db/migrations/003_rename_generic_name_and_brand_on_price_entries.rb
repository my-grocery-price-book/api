Sequel.migration do
  up do
    drop_view(:products)
    drop_view(:product_names)
    drop_view(:brand_names)
    rename_column :price_entries, :name, :generic_name
    rename_column :price_entries, :brand, :product_brand_name
    DB.create_view(:product_brand_names, DB[:price_entries].distinct.select(:product_brand_name))
    DB.create_view(:product_generic_names, DB[:price_entries].distinct.select(:generic_name))
    DB.create_view(:products, DB[:price_entries].distinct.select(:generic_name, :quanity_unit))
  end

  down do
    drop_view(:products)
    drop_view(:product_generic_names)
    drop_view(:product_brand_names)
    rename_column :price_entries, :generic_name,  :name
    rename_column :price_entries, :product_brand_name, :brand
    DB.create_view(:brand_names, DB[:price_entries].distinct.select(:brand))
    DB.create_view(:product_names, DB[:price_entries].distinct.select(:name))
    DB.create_view(:products, DB[:price_entries].distinct.select(:name, :quanity_unit))
  end
end
