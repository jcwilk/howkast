module Howkast
  class API
    service :video,
      processor: :videos,
        options: { :required => :id }
        
    service :videos,
        options: { :required => [ :sort, :filter ],
                   :optional => [ :category, :page ] }
    service :search, 
        options: { :required => :query, :optional => { :view => :video } }

    service :user,
      processor: :users,
        options: { :required => [ :id, :resource ] }

    service :playlist,
      processor: :playlists,
      options: { :required => :id }
      
    service :category,
      processor: :categories,
        options: { :required => :id }
        
    service :categories

    recognizes :key, :api_key
    def initialize opts = { }
      key = (opts[:api_key] || opts[:key])
      configuration.api_key = key if key
    end
  end
end
