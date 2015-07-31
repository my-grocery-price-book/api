module User
  # adds a price entry into storage
  class GetShopperIdForKey
    def initialize(api_key:)
      @api_key = api_key
    end

    def execute
      DB[:users].where(api_key: @api_key).map(:id).first
    end
  end
end
