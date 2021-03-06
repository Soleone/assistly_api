require 'rubygems'  # TODO: not always require rubygems
require 'ostruct'
require 'delegate'  # needed in Ruby 1.9

require 'oauth'
require 'json'

lib_dir = File.dirname(__FILE__) + '/assistly'
$LOAD_PATH.unshift(lib_dir)

require 'client'
require 'base'
require 'resource'
require 'result'
require 'authentication'
require 'case'
require 'interaction'
require 'customer'
require 'article'