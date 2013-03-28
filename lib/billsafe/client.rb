module Billsafe

	class Client
	  
    attr_accessor :base_attributes

    def initialize(base_attributes = {})
      @base_attributes = base_attributes
    end

    def call(method, attributes)
      Billsafe.request(method, base_attributes.merge(attributes))
    end

  end
end