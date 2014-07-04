require 'roar/representer'
require 'roar/representer/feature/http_verbs'
require 'roar/representer/feature/client'
# require 'roar/representer/json'
# require 'roar/rails/hal'
require 'roar/representer/json/hal'

module Billit
  module PaperworkRepresenter
    include Roar::Representer::JSON::HAL
    # include Roar::Representer::JSON

    module Initializer
      def initialize
        extend Billit::PaperworkRepresenter
        extend Roar::Representer::Feature::Client
        super
      end
    end

    def self.included(klass)
      klass.send :prepend, Initializer
      klass.send :include, Roar::Representer::Feature::HttpVerbs
    end

    property :chamber
    property :created_at
    property :date
    property :description
    property :session
    property :stage
    property :updated_at
    property :bill_uid
    property :timeline_status

    link :self do
      paperwork_url(self.id)
    end

    link :bill do
      bill_url(bill_uid)
    end

    @@timeline_status_valid_values =
    [
      'Ingreso',
      'Avanza',
      'Indicaciones',
      'Votación',
      'Urgencia',
      'Rechazado',
      'Inasistencia',
      'Descartado',
      'Informe',
      'Retiro de Urgencia',
      'Estado por Defecto'
    ]

  end
end