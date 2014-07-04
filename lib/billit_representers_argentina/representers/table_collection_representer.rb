require 'roar/representer/json'
require 'billit_representers_argentina/representers/table_representer'

module Billit
  module TableCollectionRepresenter
    include Roar::Representer::JSON
    include Roar::Representer::Feature::Hypermedia

    include Roar::Representer::JSON::HAL

    module Initializer
      def initialize
        extend Billit::TableCollectionRepresenter
        extend Roar::Representer::Feature::Client
        super
      end
    end

    def self.included(klass)
      klass.send :prepend, Initializer
      klass.send :include, Roar::Representer::Feature::HttpVerbs
    end

    collection :tables, :extend => TableRepresenter, :class => Table

    def tables
      collect
    end
  end
end