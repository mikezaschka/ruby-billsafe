$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require 'billsafe'
require 'active_model'
require 'rspec/autorun'
require 'webmock/rspec'

RSpec.configure do |config|

end