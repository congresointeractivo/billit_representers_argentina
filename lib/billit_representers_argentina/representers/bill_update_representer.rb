require 'roar/representer'
require 'roar/representer/feature/http_verbs'
require 'roar/representer/feature/client'
require 'roar/representer/json'
require 'roar/representer/json/hal'
# require 'roar/rails/hal'
require 'active_model'
require 'billit_representers_argentina/representers/paperwork_representer'
require 'billit_representers_argentina/representers/priority_representer'
require 'billit_representers_argentina/representers/report_representer'
require 'billit_representers_argentina/representers/document_representer'
require 'billit_representers_argentina/representers/directive_representer'
require 'billit_representers_argentina/representers/remark_representer'
require 'billit_representers_argentina/representers/revision_representer'
require 'billit_representers_argentina/representers/motion_representer'
require 'billit_representers_argentina/models/paperwork'
require 'billit_representers_argentina/models/priority'
require 'billit_representers_argentina/models/report'
require 'billit_representers_argentina/models/document'
require 'billit_representers_argentina/models/directive'
require 'billit_representers_argentina/models/remark'
require 'billit_representers_argentina/models/revision'
require 'billit_representers_argentina/models/motion'

module Billit
  module BillUpdateRepresenter
    include Roar::Representer::JSON::HAL
    # include Roar::Rails::HAL
    # include Roar::Representer::JSON

    module Initializer
      def initialize
        extend Billit::BillUpdateRepresenter
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
    property :title
    property :creation_date
    property :source
    property :initial_chamber
    property :stage
    property :sub_stage
    property :status
    property :resulting_document
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
  end
end