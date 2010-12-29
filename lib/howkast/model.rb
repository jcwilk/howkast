class Howkast::Model
  def self.synthesize name, data
    classname = name.modulize
    attrdef   = Proc.new{ data.keys.each{ |field| attr_reader field } }
    if const_defined? classname
      klass = const_get classname
      klass.class_eval &attrdef
      klass
    else
      const_set classname, Class.new(self, &attrdef)
    end
  end

  def initialize processor, data, &block
    data.each do |field, value| 
      value = if block and value.respond_to? :each
        block[field, value]
      elsif value.nil?
        processor.default_for field
      else
        value
      end
      instance_variable_set :"@#{field}", self.class.parse(value)
    end
  end
  
  def instance_attributes
    instance_variables.map{ |name| "#{name}"[1 .. -1].to_sym }
  end
  
  def self.parse value
    value.instance_of?(String) ? value.parse : value
  end
end
