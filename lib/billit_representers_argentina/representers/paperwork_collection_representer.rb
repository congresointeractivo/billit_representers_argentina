require 'roar/representer/json'
require 'billit_representers_argentina/representers/paperwork_representer'

module Billit
  module PaperworkCollectionRepresenter
    # include Roar::Representer
    include Roar::Representer::JSON
    include Roar::Representer::Feature::Hypermedia

    module Initializer
      def initialize
        extend Billit::PaperworkCollectionRepresenter
        extend Roar::Representer::Feature::Client
        super
      end
    end

    def self.included(klass)
      klass.send :prepend, Initializer
      klass.send :include, Roar::Representer::Feature::HttpVerbs
    end
   
    collection :paperworks, :extend => PaperworkRepresenter, :class =>  lambda { |x, *| Object.const_defined?("Paperwork") ? Paperwork : BillitPaperwork }, parse_strategy: :sync

    def paperworks
      collect
    end
  end
end