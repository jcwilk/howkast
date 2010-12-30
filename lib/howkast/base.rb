# encoding: utf-8

module Howkast
  def self.configure config = { }
    configuration = Configuration.instance
    config.each{ |k, v| configuration.send "#{k}=", v }
  end
  
  module Base
    HOWCAST_BASE_URI = 'www.howcast.com'
    def self.included base
      base.send     :include, HTTParty
      base.send     :include, HTTParty::Icebox
      
      base.base_uri HOWCAST_BASE_URI
      base.format   :xml
      base.cache    :store    => Configuration.instance.cache_store,
                    :timeout  => Configuration.instance.cache_timeout,
                    :location => Configuration.instance.cache_location
                    
      base.extend ClassMethods
    end
    
    def configuration
      Configuration.instance
    end

    private
    def request *args
      r = self.class.get *args
      raise Howkast::Error::RequestError(r.code, r.parsed_response['howcast']) \
        unless r.code == 200
      r.parsed_response['howcast']
    end
    
    module ClassMethods
      def configuration
        Configuration.instance
      end

      def services
        @services
      end
      
      def service name, spec = { }
        arguments_guard = ->(argcount) do
          maxarity = spec[:maxarity] || 1
          raise ArgumentError, "wrong number of arguments (#{argcount} for #{maxarity})" \
            unless maxarity == argcount
        end
        
        has_named_parameters name, spec[:options] || { }
        (@services ||= []) << name.to_sym
        
        define_method name do |*args, &block|
          arguments_guard[args.count]
          
          self.class.default_params api_key: configuration.api_key
          procname  = (spec[:processor] || name).to_s.modulize
          processor = Processor.const_defined?(procname) ?
                        Processor.const_get(procname) :
                        Processor::Base
                        
          path  = "/#{processor.path || name}"
          query = args.last
          args  = args[0..-2] if query.instance_of? Hash
          query = { } unless query.instance_of? Hash
          
          processor.filter args, query
          
          path << "/#{args.join('/')}" unless args.empty?
          path << '.xml'
          
          data = request(path, query: query)
          processor.parse_element data
        end
      end
    end
  end

  class API
    include Base
  end

  module Processor
  end
end