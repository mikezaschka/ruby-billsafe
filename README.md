# Billsafe

## Installation

Add this line to your application's Gemfile:

    gem 'billsafe'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install billsafe

## Usage

To disable the sandbox for using the API put this in config/initializers/billsafe.rb

    Billsafe.sandbox = false
    
The usage of the API is straightforward. First you need a client with your login information:    

    client = Billsafe::Client.new(
          merchant_id: "your-merchant_id",
          merchant_license: "your-merchant_license",
          application_signature: "your-application_signature",
          application_version: "your-application_version"
    )
    
Then you can use the client to push your calls to the API.    
    
    response = client.call("PrepareOrder", params)
    
The response is a hash with the returned values. You can fetch the values with

    token = response['token']

The full API documentation can be found here: http://www.billsafe.de/integration/manuals/BillSAFE_API.pdf


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
