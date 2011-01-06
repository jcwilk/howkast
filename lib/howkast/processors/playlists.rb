# encoding: utf-8
#
# Playlist
# - created_at
# - description
# - id
# - permalink
# - playlist_thumbnail_url
# - rating
# - thumbnail_url
# - title
# - version
# - videos*
# - videos_count
# - views
#
module Howkast::Processor
  class Playlists < Base
    class << self
      def filter args, options
        args << options.delete(:id)
        args.compact!
        options = { }
      end
      
      def parse_element data
        expander = lambda{ |key, value| expand key, value }
        if data.has_key? 'playlists'
          parse_list 'playlist', data['playlists'], &expander
        else
          klass = Howkast::Model.synthesize('Playlist', data)
          klass.new self, data, &expander
        end
      end
      
      def default_for field
        [] if %w{ playlists videos }.include? field
      end
      
      private
      def expand key, value
        case key
        when 'playlists'
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
