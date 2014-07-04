require 'roar/representer'
require 'roar/representer/feature/http_verbs'
require 'roar/representer/feature/client'
# require 'roar/representer/json'
# require 'roar/rails/hal'
require 'roar/representer/json/hal'

module Billit
  module PriorityRepresenter
    include Roar::Representer::JSON::HAL
    # include Roar::Representer::JSON

    module Initializer
      def initialize
        extend Billit::PriorityRepresenter
        extend Roar::Representer::Feature::Client
        super
      end
    end

    def self.included(klass)
      klass.send :prepend, Initializer
      klass.send :include, Roar::Representer::Feature::HttpVerbs
    end

    property :type
    property :entry_date
    property :entry_message
    property :entry_chamber
    property :withdrawal_date
    property :withdrawal_message
    property :withdrawal_chamber

  end
end