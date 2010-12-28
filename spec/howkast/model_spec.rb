require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Howkast::Model" do
  before :each do
    @foo      = 'Foo'
    @foo_data = { x: 1, y: 2, z: 3 }
    
    @bar      = 'Bar'
    @bar_data = { x: 1, y: 2, z: 3, foo: @foo_data }

    @zoo      = 'Zoo'
    @zoo_data = { x: 1, y: 2, z: 3, foo: @foo_data, bar: @bar_data }
  end
  
  it "should be able to create model types" do
    klass = Howkast::Model.synthesize(@foo, @foo_data)
    klass.should eql Howkast::Model::Foo
    klass.public_instance_methods.should include :instance_attributes
  end

  it "should be able to create model instances" do
    klass = Howkast::Model.synthesize(@foo, @foo_data)
    foo   = klass.new(self, @foo_data)
    foo.should be_an_instance_of Howkast::Model::Foo
    foo.should respond_to :instance_attributes
    @foo_data.keys.each do |attr|
      foo.should respond_to attr
    end
  end

  it "should be able to append more attributes to an existing model type" do
    klass = Howkast::Model.synthesize(@foo, @foo_data)
    foo   = klass.new(self, @foo_data)
    foo.should be_an_instance_of Howkast::Model::Foo
    @foo_data.keys.each do |attr|
      foo.should respond_to attr
    end
    
    klass = Howkast::Model.synthesize(@foo, @bar_data)
    foo   = klass.new(self, { })
    foo.should be_an_instance_of Howkast::Model::Foo
    @foo_data.merge(@bar_data).keys.each do |attr|
      foo.should respond_to attr
    end
  end
end
