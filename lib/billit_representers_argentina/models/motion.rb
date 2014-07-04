require 'billit_representers_argentina/representers/motion_representer'
class BillitMotion
  include Billit::MotionRepresenter

  def self_link
    links[:self].href if links[:self]
  end
end