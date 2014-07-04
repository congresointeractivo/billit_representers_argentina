require 'billit_representers_argentina/representers/bill_page_representer'
module Billit
  class BillPage
    include Billit::BillPageRepresenter

    def self
	  links[:self].href if links[:self]
	end

	def next
	  links[:next].href if links[:next]
	end

	def previous
	  links[:previous].href if links[:previous]
	end
  end
end