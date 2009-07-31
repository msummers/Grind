require 'rubygems'
require 'lib/grind'

class TestClass < Grind
  def initialize
    super
  end

  def test
    self.http_basic_auth_user = '11111'
    self.http_basic_auth_password = '22222'

    get("http://www.google.com/")
#		puts "Result: #{result.inspect}"
  end
end