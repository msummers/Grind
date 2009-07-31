require 'lib/grind'
require 'test_class.rb'

describe Grind do
  describe "run_tests" do
    before(:each) do
      @testClass = TestClass.new
    end
    it 'should do not bork' do
      TestClass.run_tests
    end
    it 'should have spawned the right number of objects' do
      TestClass.tests.size.should == (TestClass.number_of_threads * TestClass.iterations)
    end
    it 'should get a result for every test' do
      (0..((TestClass.number_of_threads * TestClass.iterations)-1)).each do |i|
        TestClass.tests[i-1].should_not == nil
      end
    end
    it 'should generate a benchmark for every test' do
      (TestClass.number_of_threads * TestClass.iterations).times do |i|
        TestClass.tests[i-1].timing.should_not == nil
      end
    end
  end

  describe "post" do
    before(:each) do
      @grind = Grind.new
    end
    it 'should do something' do
      @grind.post("http://www.google.com/")
    end
  end

  describe "get" do
    before(:each) do
      @grind = Grind.new
    end
    it 'should do something' do
      @grind.get("http://www.google.com/")
    end
  end

  describe "number_of_threads" do
    it "should return 1 if called without being set" do
      Grind.number_of_threads.should == 1
    end
    it "should allow setting the number of number_of_threads" do
      someValue = 666
      Grind.number_of_threads = someValue
      Grind.number_of_threads.should == someValue
    end
  end

  describe "iterations" do
    it "should return 1 if called without being set" do
      Grind.iterations.should == 1
    end
    it "should allow setting" do
      someValue = 666
      Grind.iterations = someValue
      Grind.iterations.should == someValue
    end
  end

  describe "http_basic_auth_user" do
    before(:each) do
      @grind = Grind.new
    end
    it "should return nil if called without being set" do
      @grind.http_basic_auth_user.should == nil
    end
    it "should allow setting" do
      someValue = 'joe'
      @grind.http_basic_auth_user = someValue
      @grind.http_basic_auth_user.should == someValue
    end
  end

  describe "http_basic_auth_password" do
    before(:each) do
      @grind = Grind.new
    end
    it "should return nil if called without being set" do
      @grind.http_basic_auth_password.should == nil
    end
    it "should allow setting the number of iterations" do
      someValue = 'password'
      @grind.http_basic_auth_password = someValue
      @grind.http_basic_auth_password.should == someValue
    end
  end

  describe "delay_in_seconds" do
    it "should return nil if called without being set" do
      Grind.delay_in_seconds.should == nil
    end
    it "should allow setting the number of iterations" do
      someValue = 666
      Grind.delay_in_seconds = someValue
      Grind.delay_in_seconds.should == someValue
    end
  end
end