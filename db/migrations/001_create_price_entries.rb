Sequel.migration do
  up do
    create_table :price_entries do
      primary_key :id
      String :name
      String :store
      String :location
      String :brand
      Float :quanity
      String :quanity_unit
      Float :total_price
      Date :date_on
      Date :expires_on
      Text :extra_info
    end
  end

  down do
    drop_table(:price_entries)
  end
end
