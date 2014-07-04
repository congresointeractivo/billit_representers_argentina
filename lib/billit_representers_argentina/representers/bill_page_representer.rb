require 'roar/representer/json'
require 'billit_representers_argentina/models/bill_basic'
require 'billit_representers_argentina/representers/bill_basic_representer'

module Billit
  module BillPageRepresenter

    include Roar::Representer::JSON
    include Roar::Representer::Feature::Hypermedia

    module Initializer
      def initialize
        extend Billit::BillPageRepresenter
        extend Roar::Representer::Feature::Client
        super
      end
    end

    def self.included(klass)
      klass.send :prepend, Initializer
      klass.send :include, Roar::Representer::Feature::HttpVerbs
    end

    collection :bills, :extend => Billit::BillBasicRepresenter, :class => Billit::BillBasic

    property :total_entries
    property :current_page
    property :total_pages
   
    link :self do |params|
      url_for(params.merge(:page => current_page))
    end
   
    link :next do |params|
      url_for(params.merge(:page => next_page)) \
        if next_page
    end
   
    link :previous do |params|
      url_for(params.merge(:page => previous_page)) \
        if previous_page
    end
   
    def bills
      self
    end
  end
end