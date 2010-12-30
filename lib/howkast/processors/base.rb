# encoding: utf-8

module Howkast::Processor
  class Base
    class << self
      # The name of the processor dictates the path used to communicate to the
      # API server. override to provide an alternate path.
      def path
        "#{self}".split('::').last.downcase unless "#{self}" =~ /::Base$/u
      end
      
      # Override to provide a value for field when field is nil.
      def default_for field; end
      
      # Override to massage args and options as needed.
      def filter args, options; end
      
      # Override to process data and restructure the returned value (eg: parse
      # data and return a Howkast::Model::Video instance). By default it 
      # simply returns data in its 'raw' form (the Hash from HTTParty's parsed 
      # response)
      def parse_element data
        data
      end
      
      private
      # Process an entry (identified by key) in data and return an Array of 
      # model. It assumes that data[key] represents a list of like data.
      def parse_list key, data, model = nil, &block
        Array((data || { })[key]).map do |data|
          name  = (model || key)
          klass = Howkast::Model.synthesize(name, data)
          klass.new self, data, &block
        end
      end
    end
  end
end
