$: << ENV['AKKA_HOME']

require 'java'

require 'lib/scala-library.jar'
require 'lib/akka/akka-actor-1.1.3.jar'

module Akka
  include_package 'akka.actor'
  include_package 'akka.dispatch'
end
