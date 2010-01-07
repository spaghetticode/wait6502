class InfoController < ApplicationController
  layout 'museum'
  
  def index
    @upper_image = upper_images[rand(upper_images.size)]
    @lower_image = lower_images[rand(lower_images.size)]
  end
  
  def about
  end
  
  private
  
  def upper_images 
    [
      [:altair, 'Mits Altair 8800'],
      [:atari400, 'Atari 400'],
      [:c16box, 'Commodore 16'],
      [:c64box, 'Commodore 64'],
      [:iigs, 'Apple IIgs'],
      [:pet, 'Commodore PET'],
      [:trs80m1, 'Tandy TRS-80'],
      [:trs80m12, 'Tandy TRS-80 model 12'],
      [:vicbox, 'Commodore VIC-20'],
      [:zenithz120, 'Zenith Z120']
    ]
  end
  
  def lower_images
    [
      [:cbm8032, 'Commodore 8032'],
      [:cbm8296d, 'Commodore 8296D'],
      [:advantage, 'Northstar Advantage'],
      [:challenger, 'Ohio Scientific Challenger 4P'],
      [:eagleiie, 'AVL Eagle II'],
      [:ibmpc, 'Ibm PC'],
      [:macclassic, 'Apple Macintosh Classic'],
      [:sord, 'Sord M223']
    ]
  end
end
