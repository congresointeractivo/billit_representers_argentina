require 'roar/representer'
require 'roar/representer/feature/http_verbs'
require 'roar/representer/feature/client'
require 'roar/representer/json'
require 'roar/representer/json/hal'
# require 'roar/rails/hal'
require 'active_model'
require 'billit_representers/representers/paperwork_representer'
require 'billit_representers/representers/priority_representer'
require 'billit_representers/representers/report_representer'
require 'billit_representers/representers/document_representer'
require 'billit_representers/representers/directive_representer'
require 'billit_representers/representers/remark_representer'
require 'billit_representers/representers/revision_representer'
require 'billit_representers/representers/motion_representer'
require 'billit_representers/models/paperwork'
require 'billit_representers/models/priority'
require 'billit_representers/models/report'
require 'billit_representers/models/document'
require 'billit_representers/models/directive'
require 'billit_representers/models/remark'
require 'billit_representers/models/revision'
require 'billit_representers/models/motion'

module Billit
  module BillRepresenter
    include Roar::Representer::JSON::HAL
    # include Roar::Rails::HAL
    # include Roar::Representer::JSON

    module Initializer
      def initialize
        extend Billit::BillRepresenter
        extend Roar::Representer::Feature::Client
        super
      end
    end

    def self.included(klass)
      klass.send :prepend, Initializer
      klass.send :include, ActiveModel::Validations
      klass.send :include, Roar::Representer::Feature::HttpVerbs
      klass.validates_presence_of :uid
      klass.validates :subject_areas, inclusion: { in: @@subject_areas_valid_values }
      klass.validates :stage, inclusion: { in: @@stage_valid_values }
      klass.validates :initial_chamber, inclusion: { in: @@initial_chamber_valid_values }
      klass.validates :current_priority, inclusion: { in: @@current_priority_valid_values }
    end

    property :uid
    property :short_uid
    property :title
    property :creation_date
    property :source
    property :initial_chamber
    property :current_priority
    property :stage
    property :sub_stage
    property :status
    property :resulting_document
    property :law_id
    property :bill_draft_link
    property :merged_bills
    property :subject_areas
    property :authors
    property :publish_date
    property :abstract
    property :tags

    collection :paperworks, extend: Billit::PaperworkRepresenter, class: lambda { |x, *| Object.const_defined?("Paperwork") ? Paperwork : BillitPaperwork }
    collection :priorities, extend: Billit::PriorityRepresenter, class: lambda { |x, *| Object.const_defined?("Priority") ? Priority : BillitPriority }
    collection :reports, extend: Billit::ReportRepresenter, class: lambda { |x, *| Object.const_defined?("Report") ? Report : BillitReport }
    collection :documents, extend: Billit::DocumentRepresenter, class: lambda { |x, *| Object.const_defined?("Document") ? Document : BillitDocument }
    collection :directives, extend: Billit::DirectiveRepresenter, class: lambda { |x, *| Object.const_defined?("Directive") ? Directive : BillitDirective }
    collection :remarks, extend: Billit::RemarkRepresenter, class: lambda { |x, *| Object.const_defined?("Remark") ? Remark : BillitRemark }
    collection :revisions, extend: Billit::RevisionRepresenter, class: lambda { |x, *| Object.const_defined?("Revision") ? Revision : BillitRevision }
    collection :motions, extend: Billit::MotionRepresenter, class: lambda { |x, *| Object.const_defined?("Motion") ? Motion : BillitMotion }

    link :self do
      bill_url(self.uid)
    end

    link :law_xml do 
        self.law_xml_link
    end

    link :law_web do 
        self.law_web_link
    end

    @@subject_areas_valid_values =
      [
        'Legislacion del trabajo',
        'Poblacion y desarrollo humano',
        'Juicio politico',
        'Bicameral de seguimiento de facultades delegadas al poder ejecutivo nacional - ley 25561',
        'Economias y desarrollo regional',
        'Bicameral de promocion y seguimiento de la comunicacion audiovisual (ley 26522)',
        'Especial modernizacion del funcionamiento parlamentario',
        'Energia y combustibles',
        'Bicameral de reforma del estado y seguimiento de las privatizaciones (ley 23696)',
        'Mineria',
        'Derechos humanos y garantias',
        'Intereses maritimos, fluviales, pesqueros y portuarios',
        'Familia, mujer, niñez y adolescencia',
        'Bicameral de seguimiento del tratado de las negociaciones agricolas en el marco de la omc',
        'Bicameral de fiscalizacion de organismos y actividades de inteligencia (ley 25520)',
        'Obras publicas',
        'Seguridad interior',
        'Ciencia y tecnologia',
        'Justicia',
        'Vivienda y ordenamiento urbano',
        'Libertad de expresion',
        'Legislacion penal',
        'Bicameral asesora de la federacion argentina de municipios (ley 24807)',
        'Peticiones, poderes y reglamento',
        'Agricultura y ganaderia',
        'Conmemoracion bicentenarios: revolucion de mayo (1810) y declaracion de la independencia (1816)',
        'Relaciones exteriores y culto',
        'Legislacion general',
        'Prevision y seguridad social',
        'Bicameral permanente de tramite legislativo - ley 26122',
        'Accion social y salud publica',
        'Comunicaciones e informatica',
        'Parlamentaria mixta revisora de cuentas de la administracion',
        'Mercosur',
        'Economia',
        'Prevencion de adicciones y control del narcotrafico',
        'Discapacidad',
        'Deportes',
        'Defensa del consumidor, del usuario y de la competencia',
        'Recursos naturales y conservacion del ambiente humano',
        'Turismo',
        'Defensa nacional',
        'Educacion',
        'Asuntos constitucionales',
        'Paritaria permanente (ley 24600)',
        'Analisis y seguimiento de normas tributarias y previs.',
        'Administradora de la biblioteca del congreso',
        'Cultura',
        'Bicameral de la defensoria del pueblo',
        'Bicameral fiscalizacion de organos y actividades de seguridad interior',
        'Asuntos municipales',
        'Especial seguimiento emprendimientos hidroelectricos de yacyreta, corpus, garabi y roncador',
        'De las personas mayores',
        'Mixta unicameral observatorio parlamentario sobre la cuestion malvinas',
        'Pequeñas y medianas empresas',
        'Industria',
        'Bicameral para la reforma, actualizacion y unificacion de los codigos civil y comercial de la nacion',
        'Especial de seguimiento obras para el aprovechamiento del rio bermejo',
        'Asuntos cooperativos, mutuales y de org.no gubernamentales',
        'Transportes',
        'Parlamentaria conjunta argentino chilena (ley 23172)',
        'Presupuesto y hacienda',
        'Comercio',
        'Finanzas'


      ]

    @@stage_valid_values =
      [
        'Ingresado',
        'En tratamiento',
        'Con dictámen en Cámara de Orígen',
        'Con media sanción',
        'Ingresado en Cámara Revisora.',
        'En tratamiento en Cámara Revisora',
        'Con dictámen en Cámara Revisora',
        'Sanción definitiva',
        'Promulgado por PEN',
        'Con decreto reglamentario',
        'Perdió estado parlamentario'
      ]

    @@initial_chamber_valid_values =
      [
        'Diputados',
        'Senadores'
      ]


    @@current_priority_valid_values =
      [
        'Discusión inmediata',
        'Simple',
        'Sin urgencia',
        'Suma'
      ]
  end
end