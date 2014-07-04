require 'roar/representer'
require 'roar/representer/feature/http_verbs'
require 'roar/representer/feature/client'
require 'roar/representer/json'
require 'roar/representer/json/hal'
# require 'roar/rails/hal'
require 'billit_representers_argentina/representers/count_representer'
require 'billit_representers_argentina/representers/vote_representer'
require 'billit_representers_argentina/models/count'
require 'billit_representers_argentina/models/vote'

module Billit
  module VoteEventRepresenter
    include Roar::Representer::JSON::HAL

    module Initializer
      def initialize
        extend Billit::VoteEventRepresenter
        extend Roar::Representer::Feature::Client
        super
      end
    end

    def self.included(klass)
      klass.send :prepend, Initializer
      klass.send :include, Roar::Representer::Feature::HttpVerbs
    end

    property :start_date
    property :end_date

    collection :counts, extend: Billit::CountRepresenter, class: lambda { |x, *| Object.const_defined?("Count") ? Count : BillitCount }
    collection :votes, extend: Billit::VoteRepresenter, class: lambda { |x, *| Object.const_defined?("Vote") ? Vote : BillitVote }
  end
end