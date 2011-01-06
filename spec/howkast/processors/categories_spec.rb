require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Howkast::Processor::Categories" do
  before :all do
    @config ||= YAML.load File.read(File.expand_path(File.dirname(__FILE__) + '/../../../.howkast'))
    Howkast::configure @config
    @howcast = Howkast::API.new
  end
  
  it "should raise an error if given a non-valid category ID" do
    lambda{ @howcast.category :id => '9999999999999999999999999' }.should \
      raise_error Howkast::Error::RequestError
  end

  it "should return a Category object given a valid category ID" do
    category = @howcast.category :id => 1105
    category.should be_an_instance_of Howkast::Model::Category
  end

  it "should return an array of Category objects" do
    list = @howcast.categories
    list.should be_an_instance_of Array
    list.each do |entry| 
      entry.should be_an_instance_of Howkast::Model::Category
    end
  end
end
