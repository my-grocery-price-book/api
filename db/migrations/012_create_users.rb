Sequel.migration do
  up do
    create_table :users do
      primary_key :id
      String :shopper_name
      String :email
      String :api_key
      DateTime :created_at
    end
  end

  down do
    drop_table(:users)
  end
end
