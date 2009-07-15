require 'rubygems'
require 'libxml'
require 'lib/grind'

class TestClass < Grind
  def initialize
    super
  end

  def test
    self.http_basic_auth_user = '11111'
    self.http_basic_auth_password = '22222'

    get("http://test.zavers.com/api/consumer/1/offers.xml")
  end
end