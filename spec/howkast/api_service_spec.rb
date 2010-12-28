require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Howkast::API::service" do
  before :all do
    @config ||= YAML.load File.read(File.expand_path(File.dirname(__FILE__) + '/../../.howkast'))
    Howkast::configure @config
    @howcast = Howkast::API.new
  end
  
  it "should be able to list supported services" do
    services = Howkast::API.services
    services.should be_an_instance_of Array
    services.should_not be_empty
  end
  
  it "should provide implementation for the services it supports" do
    services = Howkast::API.services
    services.should be_an_instance_of Array
    services.should_not be_empty
    howcast = Howkast::API.new
    services.each do |service|
      howcast.should respond_to service
    end
  end
  
  it "should raise an error if the category contract is broken" do
    ->{ @howcast.category :id => :id }.should_not raise_error ArgumentError
    ->{ @howcast.category }.should raise_error ArgumentError
    ->{ @howcast.category :x }.should raise_error ArgumentError
    ->{ @howcast.category :x, { :x => :x } }.should raise_error ArgumentError
    ->{ @howcast.category :x, { :id => :id } }.should raise_error ArgumentError
  end
  
  it "should raise an error if the categories contract is broken" do
    ->{ @howcast.categories }.should_not raise_error ArgumentError
    ->{ @howcast.categories :x }.should raise_error ArgumentError
    ->{ @howcast.categories :x, { :x => :x } }.should raise_error ArgumentError
    ->{ @howcast.categories :x => :x }.should raise_error ArgumentError
  end
  
  it "should raise an error if the search contract is broken" do
    ->{ @howcast.search :query => 1 }.should_not raise_error ArgumentError
    ->{ @howcast.search }.should raise_error ArgumentError
    ->{ @howcast.search :x }.should raise_error ArgumentError
    ->{ @howcast.search :x, { :x => :x } }.should raise_error ArgumentError
    ->{ @howcast.search :x, { :query => :query } }.should raise_error ArgumentError
  end
end
