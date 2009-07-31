require 'rubygems'
require 'grind'

class Test < Grind
  def initialize
    super
  end

  def test
    self.http_basic_auth_user = '11111'
    self.http_basic_auth_password = '22222'

    100.times do |consumer_id|
      get("http://www.google.com/")
    end
  end
end

Test.em