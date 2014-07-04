require 'roar/representer/feature/hypermedia'
require 'roar/representer/feature/http_verbs'
require 'roar/representer/feature/client'
require 'active_model'

module Billit
  module TableRepresenter
    include Roar::Representer::JSON::HAL

    module Initializer
      def initialize
        extend Billit::TableRepresenter
        extend Roar::Representer::Feature::Client
        super
      end
    end

    def self.included(klass)
      klass.send :prepend, Initializer
      klass.send :include, Roar::Representer::Feature::HttpVerbs
    end

    property :uid
    property :initial_chamber
    property :creation_date
    property :legislature
    property :session
    property :bills


    link :self do
      bill_url(self.uid)
    end
  end
end