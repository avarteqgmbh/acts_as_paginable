require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'active_support'
require 'active_record'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'acts_as_paginable'

class Test::Unit::TestCase
end
