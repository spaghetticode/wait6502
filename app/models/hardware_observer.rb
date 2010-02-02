class HardwareObserver < ActiveRecord::Observer
  
  # this will not enforce letter presence, but we can be pretty sure
  # that if letter exists, it will be associated.
  def before_save(hardware)
    initial = hardware.name[0,1].downcase
    hardware.letter = Letter.find_by_name(initial)
  end
end
