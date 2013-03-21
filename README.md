# Billsafe

## Installation

Add this line to your application's Gemfile:

    gem 'billsafe', "0.2.0"

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
    
    response = client.call("PrepareOrder", attributes)

The attributes hash must be filled with the required parameters for the API call. Attributes are transformed into a query string before the request is made.    
The available attributes can be read from the full documentation (see link below).

One note on filling the attributes hash:

The BillSAFE API uses keys like _order_number_ and _articleList_0_grossPrice_.
You don't have to flatten the attributes link this. Instead you can think of the underscores as a new hash:

    attributes = {
        order: {
            number: @order.order_id,
            amount: @order.credit_totals.to_f.precision(2),
            taxAmount: @order.taxes.to_f.precision(2),
            currencyCode: "EUR"
        },
        articleList: {
            0 => {
                number: item.product.sku,
                name: item.product.name,
                type: "goods",
                quantity: item.amount,
                grossPrice: item.price.to_f.precision(2),
                tax: "19.00"
            }
        }
    }

This will be transformed to:

    attributes = {
        order_number: number: @order.order_id,
        order_amount: @order.credit_totals.to_f.precision(2),
        order_taxAmount: @order.taxes.to_f.precision(2),
        order_currencyCode: "EUR",
        articleList_0_number: item.product.sku,
        articleList_0_name: item.product.name,
        articleList_0_type: "goods",
        articleList_0_quantity: item.amount,
        articleList_0_grossPrice: item.price.to_f.precision(2),
        articleList_0_tax: "19.00"
    }
    
The response is a hash with the returned values. You can fetch the values with

    token = response['token']
    
The response hash is treated like the attributes hash in a reversed way. So every key containing an underscore is beeing transformed into its own hash.

The full API documentation can be found here: http://www.billsafe.de/integration/manuals/BillSAFE_API.pdf

## Example code

    def checkout
        response = @client.call("prepareOrder", order_attributes)
        if response['token']
          redirect_to Billsafe.payment_url + "?token="+response['token']
        end
    end
    
    def success
        response = @client.call("getTransactionResult", token: params[:token])
        if response['status'] == "ACCEPTED"
            transaction_id = response['transactionId']
            ...
        else
            error_code = response['declineReason']['code']
            error_message = response['declineReason']['message']
            user_error_message = response['declineReason']['buyerMessage']
            ...
        end
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
