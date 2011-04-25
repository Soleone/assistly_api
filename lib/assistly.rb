require 'rubygems'  # TODO: not always require rubygems
require 'oauth'
require 'json'

lib_dir = File.dirname(__FILE__) + '/assistly'
$LOAD_PATH.unshift(lib_dir)

require 'base'
require 'authentication'
require 'case'
require 'interaction'