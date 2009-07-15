require 'rubygems'
require 'libxml'
require 'grind'

class Test < Grind
  def initialize
    super
  end

  def test
    self.http_basic_auth_user = '11111'
    self.http_basic_auth_password = '22222'

    100.times do |consumer_id|
      get("http://test.zavers.com/api/consumer/#{consumer_id}/offers.xml")
      begin
        parser = LibXML::XML::Parser.string(self.result.body)
        doc = parser.parse
        coupon_count =  doc.find("//coupons")[0].attributes["count"].to_i
        coupon_ids =  doc.find("//coupon_id")
#        for coupon_id in 0..coupon_count do
        coupon_ids.each do |coupon_id|
          puts "Setting coupon id: #{coupon_id.content} for consumer: #{consumer_id}"
          form_data = {'state' => "deliver", 'date_time' => "2009-07-14"}
          post("http://test.zavers.com/api/consumer/#{consumer_id}/coupon/#{coupon_id.content}.xml", form_data)
          puts "Post => "
          puts self.result.body
          return
        end
      rescue => e
      end
    end
  end
end

Test.em