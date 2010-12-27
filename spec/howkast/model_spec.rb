# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Howkast::Model" do
  before :each do
    @name = 'Foo'
    @data = { x: 1, y: 2, z: 3 }
  end
  
  it "should be able to create models types" do
    klass = Howkast::Model.synthesize(@name, @data)
    klass.should eql Howkast::Model::Foo
    klass.public_instance_methods.should include :defined_attributes
  end

  it "should be able to create model instances" do
    model    = Howkast::Model.synthesize(@name, @data)
    instance = model.new(self, @data)
    instance.should be_an_instance_of Howkast::Model::Foo
    instance.should respond_to :x
    instance.should respond_to :y
    instance.should respond_to :z
    instance.should respond_to :defined_attributes
  end
end