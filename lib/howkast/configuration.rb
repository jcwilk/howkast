# encoding: utf-8

module Howkast
  class Configuration
    include Singleton
    attr_accessor :api_key
    attr_accessor :cache_timeout
    attr_accessor :cache_location
    attr_accessor :cache_store
    
    def initialize
      @cache_timeout  = 600
      @cache_location = '/tmp/howkast/cache'
      @cache_store    = 'file'
    end
  end
end