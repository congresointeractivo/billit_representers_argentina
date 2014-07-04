require 'roar/representer/json'
require 'billit_representers_argentina/representers/table_representer'

module Billit
  module TableCollectionPageRepresenter
    include Roar::Representer::JSON
    include Roar::Representer::Feature::Hypermedia
   
    collection :tables, :extend => TableRepresenter, :class => Table

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
   
    def tables
      self
    end
  end
end