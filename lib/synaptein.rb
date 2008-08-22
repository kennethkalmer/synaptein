$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'eventmachine'
require 'activesupport'

require 'synaptein/version'
require 'synaptein/daemon'
require 'synaptein/message'
require 'synaptein/router'
require 'synaptein/receptor'
require 'synaptein/receptor/base'
require 'synaptein/receptor/http'
require 'synaptein/transmitter'
require 'synaptein/transmitter/xmpp'

module Synaptein
  
end