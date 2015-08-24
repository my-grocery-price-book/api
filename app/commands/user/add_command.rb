require 'securerandom'
require './config/enviroment'

module User
  class ValidationError < StandardError
  end

  # adds a price entry into storage
  class AddCommand
    def initialize(email:, shopper_name:)
      @email = email
      @shopper_name = shopper_name
      @api_key = SecureRandom.hex
    end

    def execute
      check_email_validation
      check_shopper_name_validation
      insert_user
      params # return the params
    end

    private

    def check_email_validation
      return unless DB[:users].where(email: @email).any?
      fail ValidationError, 'email address taken'
    end

    def check_shopper_name_validation
      return unless @shopper_name
      return unless  DB[:users].where(shopper_name: @shopper_name).empty?
      fail ValidationError, 'shopper name taken'
    end

    def insert_user
      DB[:users].insert(params.merge(created_at: Time.now))
    end

    def params
      { email: @email,
        shopper_name: @shopper_name,
        api_key: @api_key }
    end
  end
end
