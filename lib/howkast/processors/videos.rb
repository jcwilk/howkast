#
# Video
# - badges
# - category_hierarchy*
# - category_id
# - comment_count
# - comments*
# - content_rating
# - created_at
# - description
# - duration
# - easy_steps
# - edit_url
# - embed
# - filename
# - filename  
# - height
# - id
# - ingredients*
# - markers*
# - overlay*
# - permalink
# - rating
# - related_videos*
# - state
# - tags
# - thumbnail_url
# - title
# - type
# - username
# - views
# - width
#
# Marker
# - id
# - position
# - timemarker
# - type
# - thumbnail_url
# - title
# - textile_text
# - text
#
module Howkast::Processor
  class Videos < Base
    class << self
      def filter args, options
        args << options.delete(:id)
        args << options.delete(:sort)
        args << options.delete(:filter)
        args << options.delete(:category)
        args << options.delete(:page)
        args.compact!
      end
      
      def parse_element data
        expander = ->(key, value){ expand key, value }
        if data.has_key? 'video'
          data  = data['video']
          klass = Howkast::Model.synthesize('Video', data)
          klass.new self, data, &expander
        else
          parse_list 'video', data['videos'], &expander
        end
      end
      
      def default_for field
        [] if %w{ category_hierarchy ingredients markers related_videos }.include? field
      end
      
      private
      def expand key, value
        case key
        when 'category_hierarchy'
          value['category'] = value['category'].map{ |category| { 'name' => category } }
          Categories.parse_element 'categories' => value
          #value['category']
        when 'comments'
          value['count']
        when 'ingredients'
          value['ingredient']
        when 'markers'
          parse_list 'marker', value
        when 'related_videos'
          parse_element 'videos' => value
        when 'overlay'
          klass = Howkast::Model.synthesize('Overlay', value)
          klass.new self, value
        else 
          value
        end
      end
    end
  end
end
