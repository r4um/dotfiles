# vim: set et ft=ruby ts=2 sw=2 tw=79: #

require 'json'
require 'pp'
require 'yaml'

Pry.config.memory_size = 500
Pry.config.editor = lambda{ |file, line| "vim #{file} +#{line}" }

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

def rd
  puts RUBY_DESCRIPTION
end
