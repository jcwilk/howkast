module Howkast
  module Error
    RequestError = Class.new(StandardError)
  
    def self.RequestError(code, data)
      msg   = data['response']['err']['msg'] unless data.nil?
      const = msg ? "#{msg.gsub(/\w+/){ $&.capitalize }.gsub(/ /, '')}" : "HTTP#{code}"
      klass = if Howkast::Error.const_defined? const
        Howkast::Error.const_get const
      else
        Howkast::Error.const_set const, Class.new(RequestError)
      end
      klass.new(msg)
    end
  end
end
