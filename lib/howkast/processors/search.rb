# encoding: utf-8
#
# Search
# - title
# - videos*
# - version
# 
module Howkast::Processor
  class Search < Base
    class << self
      def filter args, options
        options[:q] = options.delete(:query)
      end
      
      def parse_element data
        expander = ->(key, value){ expand key, value }
        klass    = Howkast::Model.synthesize('Search', data)
        klass.new self, data, &expander
      end
      
      def default_for field
        [] if %w{ videos }.include? field
      end
      
      private
      def expand key, value
        case key
        when 'videos'
          Videos.parse_element 'videos' => value
        else
          value
        end
      end
    end
  end
end
