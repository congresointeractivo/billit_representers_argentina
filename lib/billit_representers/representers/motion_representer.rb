require 'roar/representer'
require 'roar/representer/feature/http_verbs'
require 'roar/representer/feature/client'
require 'roar/representer/json'
require 'roar/representer/json/hal'
# require 'roar/rails/hal'
require 'billit_representers/representers/vote_event_representer'
require 'billit_representers/representers/count_representer'
require 'billit_representers/models/vote_event'
require 'billit_representers/models/count'

module Billit
  module MotionRepresenter
    include Roar::Representer::JSON::HAL

    module Initializer
      def initialize
        extend Billit::MotionRepresenter
        extend Roar::Representer::Feature::Client
        super
      end
    end

    def self.included(klass)
      klass.send :prepend, Initializer
      klass.send :include, Roar::Representer::Feature::HttpVerbs
    end

    property :organization
    property :context
    property :creator
    property :text
    property :date
    property :requirement
    property :result
    property :session

    collection :vote_events, extend: Billit::VoteEventRepresenter, class: lambda { |x, *| Object.const_defined?("VoteEvent") ? VoteEvent : BillitVoteEvent }, parse_strategy: :sync

    link :self do
      motion_url(self.id)
    end
  end
end