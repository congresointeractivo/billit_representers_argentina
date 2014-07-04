require 'billit_representers_argentina/representers/bill_basic_representer'
module Billit
  class BillBasic
    include Billit::BillBasicRepresenter

    attr_reader :representable_attrs

    def self_link
	  links[:self].href if links[:self]
	end

	def law_xml_link
	  links[:law_xml].href if links[:law_xml]
	end

	def law_web_link
	  links[:law_web].href if links[:law_web]
	end

	def bill_draft_link
	  links[:bill_draft].href if links[:bill_draft]
	end
  end
end