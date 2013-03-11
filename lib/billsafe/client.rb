module Billsafe

	class Client
	  
    attr_accessor :base_attributes

    def initialize(base_attributes = {})
      @base_attributes = base_attributes
    end

    def call(method, attributes)
      response = Billsafe.request(method, base_attributes.merge(attributes))
      response
    end

  end
end