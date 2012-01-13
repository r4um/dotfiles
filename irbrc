require 'rubygems'
require 'readline'
require 'wirble'
require 'pp'

Wirble.init
Wirble.colorize

IRB.conf[:USE_READLINE] = true
IRB.conf[:PROMPT_MODE]  = :SIMPLE
IRB.conf[:AUTO_INDENT]  = true

IRB.conf[:SAVE_HISTORY] = 1500
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irbhistory"

IRB.conf[:LOAD_MODULES] = []  unless IRB.conf.key?(:LOAD_MODULES)

unless IRB.conf[:LOAD_MODULES].include?('irb/completion')
    IRB.conf[:LOAD_MODULES] << 'irb/completion'
    IRB.conf[:LOAD_MODULES] << 'irb/ext/save-history'
end      

class Object
    def local_methods
        (methods - Object.instance_methods).sort
    end
end

puts ">> ~/.irbrc loaded successfully."
