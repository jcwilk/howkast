require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Howkast::Model" do
  before :each do
    @foo      = 'Foo'
    @foo_data = { :x => 1, :y => 2, :z => 3 }
    
    @bar      = 'Bar'
    @bar_data = { :x => 1, :y => 2, :z => 3, :foo => @foo_data }

    @zoo      = 'Zoo'
    @zoo_data = { :x => 1, :y => 2, :z => 3, :foo => @foo_data, :bar => @bar_data }
  end
  
  it "should be able to create model types" do
    klass = Howkast::Model.synthesize(@foo, @foo_data)
    klass.should eql Howkast::Model::Foo
    klass.public_instance_methods.map{ |method| method.to_sym }.should include :instance_attributes
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
  
  it "should be able to parse a String value and convert it to an appropriate type" do
    Howkast::Model.parse("String").should be_an_instance_of String
    Howkast::Model.parse("1x").should be_an_instance_of String
    Howkast::Model.parse("1").should be_an_instance_of Fixnum
    Howkast::Model.parse("11111111").should be_an_instance_of Fixnum
    Howkast::Model.parse("+1").should be_an_instance_of Fixnum
    Howkast::Model.parse("-1").should be_an_instance_of Fixnum
    Howkast::Model.parse("0.1x").should be_an_instance_of Float
    Howkast::Model.parse("0.1").should be_an_instance_of Float
    Howkast::Model.parse("0.111111").should be_an_instance_of Float
    Howkast::Model.parse("+0.1").should be_an_instance_of Float
    Howkast::Model.parse("-0.1").should be_an_instance_of Float
    Howkast::Model.parse("+0.1111111").should be_an_instance_of Float
    Howkast::Model.parse("-0.1111111").should be_an_instance_of Float
    Howkast::Model.parse("true").should be_an_instance_of TrueClass
    Howkast::Model.parse("True").should be_an_instance_of TrueClass
    Howkast::Model.parse("TRUE").should be_an_instance_of TrueClass
    Howkast::Model.parse("false").should be_an_instance_of FalseClass
    Howkast::Model.parse("False").should be_an_instance_of FalseClass
    Howkast::Model.parse("FALSE").should be_an_instance_of FalseClass
    Howkast::Model.parse("Sun, 3 Jul 2008 20:00:39 -0700").should be_an_instance_of Time
    Howkast::Model.parse("Mon, 14 Jul 2008 20:00:39 -0700").should be_an_instance_of Time
    Howkast::Model.parse("Wed Dec 29 12:21:32 PST 2010").should be_an_instance_of Time
    Howkast::Model.parse("Wed Dec  1 12:21:32 PST 2010").should be_an_instance_of Time
    Howkast::Model.parse("Wed Dec 7 12:21:32 PST 2010").should be_an_instance_of Time
  end
end
