# encoding: utf-8

require 'rubygems'

require 'time'
require 'singleton'
require 'active_support/memoizable'
require 'httparty'
require 'named-parameters'

require 'howkast/ext/string'
#require 'howkast/ext/icebox'

require 'howkast/configuration'
require 'howkast/errors'
require 'howkast/model'
require 'howkast/base'
require 'howkast/api'

Dir[File.join(File.dirname(__FILE__), 'howkast', 'processors', '*')].each do |processor|
  require processor
end
