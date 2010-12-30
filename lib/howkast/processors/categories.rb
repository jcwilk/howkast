# encoding: utf-8
#
# Category
# - id
# - name
# - parent_id
# - permalink
# - parents*
# - subcategories*
#
module Howkast::Processor
  class Categories < Base
    class << self
      def filter args, options
        args << options.delete(:id)
        args.compact!
        options = { }
      end
      
      def parse_element data
        expander = ->(key, value){ expand key, value }
        if data.has_key? 'category'
          data  = data['category']
          klass = Howkast::Model.synthesize('Category', data)
          klass.new self, data, &expander
        else
          parse_list 'category', data['categories'], &expander
        end
      end
      
      def default_for field
        [] if %w{ parents categories subcategories }.include? field
      end
      
      private
      def expand key, value
        case key
        when 'parents'
          value['category'] = [value['category']] \
            unless value['category'].instance_of? Array
          parse_element 'categories' => value
        when 'subcategories' 
          parse_element 'categories' => value
        else 
          value
        end
      end
    end
  end
end
