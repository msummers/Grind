require 'net/http'
require 'benchmark'
class Grind

  def self.tests
    @@tests
  end

  @@iterations = 1
  def self.iterations=(i)
    @@iterations = i
  end
  def self.iterations
    @@iterations
  end

  @@number_of_threads = 1
  def self.number_of_threads=(i)
    @@number_of_threads = i
  end
  def self.number_of_threads
    @@number_of_threads
  end

  @@delay_in_seconds = nil
  def self.delay_in_seconds=(i)
    @@delay_in_seconds = i
  end
  def self.delay_in_seconds
    @@delay_in_seconds
  end

  attr_accessor :http_basic_auth_user, :http_basic_auth_password, :timing, :result
  def initialize
    @http_basic_auth_user = nil
    @http_basic_auth_password = nil
    @timing = Array.new
  end

  def get(uri, options = nil)
    url = URI.parse(uri)
    req = Net::HTTP::Get.new(url.path)
    req.basic_auth(@http_basic_auth_user, @http_basic_auth_password) unless @http_basic_auth_user.nil?
    @timing << {:url => url, :time =>  Benchmark.measure do
        @result = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
      end
    }
  end

  def post(uri, form_data = {})
    url = URI.parse(uri)
    req = Net::HTTP::Post.new(url.path)
    req.basic_auth(@http_basic_auth_user, @http_basic_auth_password) unless @http_basic_auth_user.nil?
    #
    # If you set the form data separator to ';' the post will be in multiple HTTP packets which will fail at the server!
    #
    req.set_form_data(form_data, '&')
    @timing << {:url => url, :time =>  Benchmark.measure do
        @result = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
      end
    }
  end

  def self.run_tests
    self.iterations.times do
      threads = Array.new(self.number_of_threads)
      @@tests = Array.new
      thread = nil
      self.number_of_threads.times do
        worker = self.new
        thread = Thread.new(worker) do |p|
          @@tests << p
          p.test
          sleep(rand(self.delay_in_seconds)) unless self.delay_in_seconds.nil?
        end
        threads << thread
      end
      threads.each do |t|
        t.join unless t.nil?
      end
    end
  end
end