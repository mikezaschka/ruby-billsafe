require "billsafe/version"
require 'active_support/all'

module Billsafe

  API_BASE          = "nvp.billsafe.de/"
  API_BASE_SANDBOX  = "sandbox-nvp.billsafe.de"
  API_VERSION       = "V208"

  PAYMENT_BASE          = "payment.billsafe.de"
  PAYMENT_BASE_SANDBOX  = "sandbox-payment.billsafe.de"
  PAYMENT_VERSION       = "V200"

  @@sandbox = true

	autoload :Client, "billsafe/client"

  class BillsafeError < StandardError
  end

  class AuthenticationError < BillsafeError; end
  class APIError            < BillsafeError; end
  class ArgumentError       < BillsafeError; end

  class << self
    def sandbox?
      @@sandbox
    end

    def sandbox=(sandbox)
      @@sandbox = sandbox
    end

    def payment_url
      api_base = Billsafe.sandbox? ? PAYMENT_BASE_SANDBOX : PAYMENT_BASE
      "https://#{api_base}/#{PAYMENT_VERSION}"
    end

    def request(api_method, data)
      api_base = Billsafe.sandbox? ? API_BASE_SANDBOX : API_BASE
      https = Net::HTTP.new(api_base , Net::HTTP.https_default_port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      https.start do |connection|
        path = "/#{API_VERSION}"
        https_request = Net::HTTP::Post.new(path)
        https_request.body = nvp_params(data.merge(method: api_method, format: 'JSON'))
        @response = https.request(https_request)
      end
      raise AuthenticationError if @response.code.to_i == 401
      raise APIError if @response.code.to_i >= 500

      data = JSON.parse(@response.body)
      raise APIError.new(data['errorList'].
                             map{ |err| [err['code'], err['message']].join(" ")}.join("\r\n")) if data["ack"] == "ERROR"
      deflatten_params(data)
    end

    def nvp_params(params)
      flattened_params = flatten_params(params)
      URI.encode_www_form(flattened_params)
    end

    def flatten_params(hash, prefix = "")
      new_hash = {}
      hash.each_pair do |key, val|
        if val.is_a?(Hash)
          new_hash.merge!(flatten_params(val, prefix + key.to_s + "_"))
        else
          new_hash[prefix + key.to_s] = val
        end
      end
      new_hash
    end

    def deflatten_params(hash)
      new_hash = {}
      hash.each_pair do |key, val|
        if key.include? "_"
          parts = key.split("_")
          parts.reverse.each do |part|
            val = { part => val }
          end
        else 
          val = { key => val }
        end
        new_hash.deep_merge!(val)  
      end        
      new_hash
    end

  end
end
