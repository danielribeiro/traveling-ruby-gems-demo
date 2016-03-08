#!/usr/bin/env ruby
require 'faker'
puts "hello #{Faker::Name.name}"
print 'argv = '
p ARGV
puts "done"