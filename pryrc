# vim: set et ft=ruby ts=2 sw=2 tw=79: #

require 'json'
require 'net/http'
require 'pp'
require 'yaml'

Pry.config.memory_size = 500
Pry.config.editor = lambda{ |file, line| "vim #{file} +#{line}" }
Pry.config.pager = false

def add_lib_to_load_path
  $LOAD_PATH << File.join(Dir.pwd, "lib")
end

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

def rd
  puts RUBY_DESCRIPTION
end

def hc(c)
  obj = Net::HTTPResponse::CODE_TO_OBJ[c.to_s]
  "#{obj} - http://httpstatus.es/#{c}" if obj
end
