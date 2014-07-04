require 'roar/representer'
require 'roar/representer/feature/http_verbs'
require 'roar/representer/feature/client'
require 'roar/representer/json'
require 'roar/representer/json/hal'
# require 'roar/rails/hal'

module Billit
  module CountRepresenter
    include Roar::Representer::JSON::HAL

    module Initializer
      def initialize
        extend Billit::CountRepresenter
        extend Roar::Representer::Feature::Client
        super
      end
    end

    def self.included(klass)
      klass.send :prepend, Initializer
      klass.send :include, Roar::Representer::Feature::HttpVerbs
    end

    property :option
    property :value
  end
end