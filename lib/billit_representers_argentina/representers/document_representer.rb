require 'roar/representer'
require 'roar/representer/feature/http_verbs'
require 'roar/representer/feature/client'
# require 'roar/representer/json'
# require 'roar/rails/hal'
require 'roar/representer/json/hal'

module Billit
  module DocumentRepresenter
    include Roar::Representer::JSON::HAL
    # include Roar::Representer::JSON

    module Initializer
      def initialize
        extend Billit::DocumentRepresenter
        extend Roar::Representer::Feature::Client
        super
      end
    end

    def self.included(klass)
      klass.send :prepend, Initializer
      klass.send :include, Roar::Representer::Feature::HttpVerbs
    end

    property :number
    property :date
    property :step
    property :stage
    property :type
    property :chamber
    property :link

  end
end