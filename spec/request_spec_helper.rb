module RequestSpecHelper

  def stub_ok_request(token, status = 200)
    stub_request(:get, "https://sandbox-nvp.billsafe.de/V209?Order_currencyCode=EUR&format=json&method=PrepareOrder").
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => '{
          "ack":"OK",
          "status":"ACCEPTED",
          "transactionId":"987654321",
          "token":"' + token + '"}', :headers => {})
  end

  def stub_error_request()
    stub_request(:get, "https://sandbox-nvp.billsafe.de/V209?Order_currencyCode=EUR&format=json&method=PrepareOrder").
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => '{
            "ack":"ERROR",
            "errorList":[
              { "code":"123", "message":"Fehler 1" },
              { "code":"456", "message":"Fehler 2"}
            ]
        }', :headers => {})
  end

end