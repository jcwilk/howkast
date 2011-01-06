# encoding: utf-8
#
# title
# login
# count
# views
# firstname
# lastname
# thumbnail_url
# videos
# version
#
#created_at
#description
#id
#permalink
#rating
#thumbnail_url
#title
#videos_count
#views
#
module Howkast::Processor
  class Users < Base
    class << self
      def filter args, options
        args << options.delete(:id)
        args << :profile
        args << Array(options.delete(:resource))
        args.compact!
      end

      def parse_element data
        expander = lambda{ |key, value| expand key, value }
        if data.has_key? 'records'
          data['playlists'] = nil
          data.delete 'records'
        end
        klass = Howkast::Model.synthesize('User', data)
        klass.new self, data, &expander
      end
      
      def default_for field
        [] if %w{ playlists videos }.include? field
      end
      
      private
      def expand key, value
        case key
        when 'playlists', 'records'
          Playlists.parse_element 'playlists' => value
        when 'videos'
          Videos.parse_element 'videos' => value
        else
          value
        end
      end
    end
  end
end
